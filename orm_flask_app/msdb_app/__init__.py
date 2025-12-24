from flask import Flask, render_template, redirect, request, session, url_for
import os, json

from sqlalchemy import text
from .extensions import db
from .models import *
from . import spotApi

from requests_oauthlib import OAuth2Session
from flask_session import Session
from werkzeug.middleware.proxy_fix import ProxyFix
#from waitress import serve

host=os.environ['SQL_HOST']
user=os.environ['SQL_USER']
password=os.environ['SQL_PWD']
db_name=os.environ['SQL_DB']

with open("./secrets.json") as f:
    authCreds = json.load(f)["authentik"]

# App configuration
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{user}:{password}@{host}/{db_name}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

app.secret_key = os.urandom(24)
app.config['PERMANENT_SESSION_LIFETIME'] = 1800
# TODO: At some point need to set up cron job for cleaning up old sessions - use 'flask session_cleanup' command
app.config['SESSION_TYPE'] = 'sqlalchemy'
app.config['SESSION_SQLALCHEMY'] = db
Session(app)

# Authentik OAuth2 Configuration
client_id = authCreds["client_id"]
client_secret = authCreds["client_secret"]
authorization_base_url = authCreds["authorization_base_url"]
token_url = authCreds["token_url"]
redirect_uri = authCreds["redirect_uri"]
userinfo_url = authCreds["userinfo_url"]

# TODO: Remove when HTTPS is set up correctly
#os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'
app.wsgi_app = ProxyFix(app.wsgi_app, x_for=1, x_proto=1)

# TODO: Look into Blueprints and defaults
def checkAdmin():
    if session.get('admin'):
        return True
    else:
        return False

songKeys = ['N/A', 'AM', 'Am', 'BbM', 'Bbm', 'BM', 'Bm', 'CM', 'Cm', 'DbM', 'Dbm', 'DM', 
            'Dm', 'EbM', 'Ebm', 'EM', 'Em', 'FM', 'Fm', 'GbM', 'Gbm', 'GM', 'Gm']

@app.route('/')
def index():
    # if session.get('user') is None and session.get('logged_out') is not True:
    #     return redirect('/login')
    return render_template("home.html")

@app.route('/login')
def login():
    if session.get('user') is not None:
        return redirect('/login/success')
    else:
        authentik = OAuth2Session(client_id, redirect_uri=redirect_uri)
        authorization_url, state = authentik.authorization_url(authorization_base_url)
        session['oauth_state'] = state
        return redirect(authorization_url)
    
@app.route('/login/callback')
def callback():
    authentik = OAuth2Session(client_id, state=session['oauth_state'], redirect_uri=redirect_uri)
    token = authentik.fetch_token(token_url, client_secret=client_secret,
                                authorization_response=request.url)
    
    session['oauth_token'] = token
    userinfo = authentik.get(userinfo_url).json()
    session['user'] = userinfo
    if 'MSDB Admins' in userinfo['groups']:
        session['admin'] = True
    else:
        session['admin'] = False
    return redirect('/login/success')

@app.route('/login/success')
def login_success():
    return render_template("userinfo.html", success=True)

@app.route('/userinfo')
def userinfo():
    if session.get('user') is None:
        return redirect('/')
    else:
        return render_template("userinfo.html")

@app.route('/logout')
def logout():
    if session.get('user') is None:
        return redirect('/')
    else:
        session.clear()
        session['logged_out'] = True
        # TODO: remove _external and _scheme after setting up WSGI
        if request.referrer == url_for('login_success', _external=True, _scheme='https') or request.referrer == url_for('userinfo', _external=True, _scheme='https'):
            return redirect('/')
        else:
            return redirect(request.referrer or '/')

@app.route('/denied')
def denied():
    return render_template("denied.html")

### Artists
@app.route('/artists')
def showArtists():
    if request.args.get('artist_id'):
        return redirect(f"/artists/{request.args.get('artist_id')}")
    else:
        artists = Artist.query.all()
        return render_template("showartists.html", artists=artists)

@app.route('/artists/<int:artist_id>')
def showArtistByID(artist_id):
    artist = Artist.query.get(artist_id)
    if artist is None:
        return redirect('/artists')
    return render_template("showartist.html", artist=artist)

@app.route('/insertartist')
def insertArtistForm():
    if not checkAdmin():
        return redirect('/denied')
    songsAvailable = Song.query.all()
    return render_template("insertform.html", t="artist", songsAvailable=songsAvailable)

@app.route('/newartist')
def insertArtist():
    if not checkAdmin():
        return redirect('/denied')
    if request.args.get('name') is not None:
        artist = Artist(
            name=request.args.get("name"), 
            nationality=request.args.get("nationality"), 
            genre=request.args.get("genre"),
        )
        if request.args.getlist('songs'):
                for song in request.args.getlist('songs'):
                    if song == '' or song is None:
                        continue
                    else: 
                        s = Song.query.get(song)
                        artist.songs.append(s)
        db.session.add(artist)
        db.session.commit()
        return redirect("artists")
    else:
        return redirect("insertartist")
    
@app.route('/updateartist')
def updateArtist():
    if not checkAdmin():
        return redirect('/denied')
    artist = Artist.query.get(request.args.get('artist_id'))
    artist.name = request.args.get('name')
    artist.nationality = request.args.get('nationality')
    artist.genre = request.args.get('genre')
    songs = [int(x) for x in request.args.getlist('songs')]

    for song in artist.songs:
        if song.song_id not in songs:
            s = Song.query.get(song.song_id)
            artist.songs.remove(s)
    for song in songs:
        if song == '' or song is None:
            continue
        else: 
            s = Song.query.get(song)
            if s in artist.songs:
                continue
            else:
                artist.songs.append(s)
    db.session.commit()
    return redirect('artists')

### Songs
@app.route('/songs')
def showSongs():
    if request.args.get('song_id'):
        return redirect(f"/songs/{request.args.get('song_id')}")
    else:
        songs = Song.query.all()
        return render_template("showsongs.html", songs=songs)

@app.route('/songs/<int:song_id>')
def showSongByID(song_id):
    song = Song.query.get(song_id)
    if song is None:
        return redirect('/songs')
    return render_template("showsong.html", song=song)

@app.route('/insertsong')
def insertSongForm():
    if not checkAdmin():
        return redirect('/denied')
    artists = Artist.query.all()
    return render_template("insertform.html", t="song", songKeys=songKeys, artistsAvailable=artists)

@app.route('/newsong')
def insertSong():
    if not checkAdmin():
        return redirect('/denied')
    if request.args.get('title') is not None:
        song = Song(
            title = request.args.get('title'),
            key = request.args.get('key'),
            bpm = request.args.get('bpm'),
            genre = request.args.get('genre'),
            ISRC = request.args.get('ISRC')
        )
        if request.args.getlist('artists'):
                for artist in request.args.getlist('artists'):
                    if artist == '' or artist is None:
                        continue
                    else: 
                        a = Artist.query.get(artist)
                        song.artists.append(a)
        db.session.add(song)
        db.session.commit()
        return redirect("songs")
    
@app.route('/updatesong')
def updateSong():
    if not checkAdmin():
        return redirect('/denied')
    song_id = request.args.get('song_id')
    song = Song.query.get(song_id)
    song.title = request.args.get('title')
    song.key = request.args.get('key')
    song.genre = request.args.get('genre')
    song.bpm = request.args.get('bpm')
    song.ISRC = request.args.get('ISRC')

    artists = [int(x) for x in request.args.getlist('artists')]

    for artist in song.artists:
        if artist.artist_id not in artists:
            a = Artist.query.get(artist.artist_id)
            song.artists.remove(a)
            print(f"Removed song {a.name} {a.artist_id} from {song.song_id}")
    for artist in artists:
        if artist == '' or artist is None:
            continue
        else: 
            a = Artist.query.get(artist)
            if a in song.artists:
                continue
            else:
                song.artists.append(a)

    db.session.commit()
    return redirect(f'songs?song_id={song_id}')

### Samples and Repos

@app.route('/samples')
def showSamples():
    sample_id = request.args.get('sample_id')
    if sample_id:
        return redirect(f"/samples/{sample_id}")
    else:
        samples = Sample.query.all()
        sources = {}
        for sample in samples:
            source_id = sample.source_id
            if Song.query.filter_by(source_id=source_id).first() is not None:
                song = Song.query.filter_by(source_id=source_id).first()
                sources[source_id] = {"link": "/songs/" + str(song.song_id), "name": song.title}
            elif Repo.query.filter_by(source_id=source_id).first() is not None:
                repo = Repo.query.filter_by(source_id=source_id).first()
                sources[source_id] = {"link": "/repo/" + str(repo.source_id), "name": repo.name}
        return render_template("showsamples.html", samples=samples, sources=sources)

@app.route('/samples/<int:sample_id>')
def showSample(sample_id):
    sample = Sample.query.get(sample_id)
    source_id = sample.source_id
    # check if sampleSource is a song or repo
    if Song.query.filter_by(source_id=source_id).first() is not None:
        song = Song.query.filter_by(source_id=source_id).first()
        return render_template("showsample.html", sample=sample, song=song)
    else:
        repo = Repo.query.filter_by(source_id=source_id).first()
        return render_template("showsample.html", sample=sample, repo=repo)

@app.route('/repo')
def showRepos():
    source_id = request.args.get('id')
    if source_id:
        return redirect(f"/repo/{source_id}")
    else:
        repos = Repo.query.all()
        return render_template("showrepos.html", repos=repos)

@app.route('/repo/<int:source_id>')
def showRepo(source_id):
    repo = Repo.query.get(source_id)
    return render_template("showrepo.html", repo=repo)

@app.route('/insertrepo')
def insertRepoForm():
    if not checkAdmin():
        return redirect('/denied')
    return render_template("insertform.html", t="repo")

@app.route('/newrepo')
def insertRepo():
    if not checkAdmin():
        return redirect('/denied')
    if request.args.get('name') is not None:
        repo = {
            'name': request.args.get('name'),
            'type': request.args.get('type'),
            'custodian': request.args.get('custodian'),
            'price': request.args.get('price'),
            'billed': request.args.get('billed')
        }
        query = "INSERT INTO repo (name, type, custodian, price, billed) values (:name, :type, :custodian, :price, :billed)"
        db.session.execute(text(query),repo)
        db.session.commit()
        return redirect(f"repo")
    else:
        return redirect("insertrepo")

@app.route('/updaterepo')
def updateRepo():
    if not checkAdmin():
        return redirect('/denied')
    source_id = request.args.get('source_id')
    repo = Repo.query.get(source_id)
    repo.name = request.args.get('name')
    repo.type = request.args.get('type')
    repo.custodian = request.args.get('custodian')
    repo.price = request.args.get('price')
    repo.billed = request.args.get('billed')
    db.session.commit()
    return redirect(f'repo?id={source_id}')

@app.route('/insertsample')
def insertSampleForm():
    if not checkAdmin():
        return redirect('/denied')
    sources = []
    for s in Song.query.all():
        sources.append(s)
    for r in Repo.query.all():
        sources.append(r)
    
    # Get songs by artist 1 (me) for "used on" selection
    songsAvailable = Artist.query.get(1).songs
    return render_template("insertform.html", t="sample", sources=sources, songsAvailable=songsAvailable)

@app.route('/updatesample')
def updateSample():
    if not checkAdmin():
        return redirect('/denied')
    sample_id = request.args.get('sample_id')
    sample = Sample.query.get(sample_id)
    sample.instrument = request.args.get('instrument')
    sample.genre = request.args.get('genre')
    sample.source_id = request.args.get('source_id')

    songs = [int(x) for x in request.args.getlist('on_songs')]

    for song in sample.on_songs:
        if song not in songs:
            s = Song.query.get(song.song_id)
            sample.on_songs.remove(s)
    for song in songs:
        if song == '' or song is None:
            continue
        else: 
            s = Song.query.get(song)
            if s in sample.on_songs:
                continue
            else:
                sample.on_songs.append(s)

    db.session.commit()
    return redirect(f'samples?sample_id={sample_id}')

@app.route('/newsample')
def insertSample():
    if not checkAdmin():
        return redirect('/denied')
    sample = Sample(
        instrument=request.args.get('instrument'),
        genre=request.args.get('genre'),
        source_id=request.args.get('source_id')
    )
    if request.args.getlist('on_songs'):
            for song in request.args.getlist('on_songs'):
                if song == '' or song is None:
                    continue
                else: 
                    s = Song.query.get(song)
                    sample.on_songs.append(s)

    db.session.add(sample)
    db.session.commit()
    return redirect(f'samples?sample_id={sample.sample_id}')

### Releases

@app.route('/release', methods=['GET', 'POST'])
def showRelease(UPC=None):
    if request.method == 'GET':
        UPC = request.args.get('UPC')
    if request.method == 'POST':
        UPC = request.form.get('UPC')
    if UPC:
        release = Release.query.get(UPC)
        if release.url is None or release.url == 'None' or release.url == '':
            cover_url = None
        else:
            cover_url = spotApi.get_album_cover(release.url)
        otherReleases = [r for r in Release.query.all() if r.UPC != release.UPC]
        return render_template("showrelease.html", release=release, otherReleases=otherReleases, cover_url=cover_url)
    else:
        otherReleases = Release.query.all()
        return render_template("showrelease.html", otherReleases=otherReleases)

@app.route('/updaterelease')
def updateRelease():
    if not checkAdmin():
        return redirect('/denied')
    UPC = request.args.get('UPC')
    if UPC:
        # This method allows for partial updates, but also still requires UPC (the primary key)
        attrs = request.args
        release = Release.query.get(UPC)

        songs = [int(x) for x in request.args.getlist('songs') if x != '-1']
        
        for i in request.args:
            if i == 'songs':

                for song in release.songs:
                    if song.song_id not in songs:
                        s = Song.query.get(song.song_id)
                        release.songs.remove(s)
                        print(f"Removed song {s.title} {s.song_id} from release {release.UPC}")
                for song in songs:
                    if song == '' or song is None:
                        continue
                    else: 
                        s = Song.query.get(song)
                        if s in release.songs:
                            continue
                        else:
                            release.songs.append(s)

            else:
                release.__setattr__(i, attrs[i])
        db.session.commit()
        return redirect(f'release?UPC={UPC}')
    else:
        return redirect('/release')

@app.route('/insertrelease')
def insertReleaseForm():
    if not checkAdmin():
        return redirect('/denied')
    otherSongs = Song.query.all()
    return render_template("insertform.html", t="release", songsAvailable=otherSongs)

@app.route('/newrelease')
def insertRelease():
    if not checkAdmin():
        return redirect('/denied')
    if request.args.get('UPC') is not None:
        release = Release(
            UPC=request.args.get('UPC'),
            title=request.args.get('title'),
            type=request.args.get('type'),
            numSongs=request.args.get('numSongs'),
            releaseDate=request.args.get('releaseDate')
        )
        if request.args.getlist('songs'):
            for song in request.args.getlist('songs'):
                if song == '' or song is None:
                    continue
                else: 
                    s = Song.query.get(song)
                    release.songs.append(s)
        if request.args.get('url'):
            release.url = request.args.get('url')
        db.session.add(release)
        db.session.commit()
        return redirect(f"release?UPC={release.UPC}")
    else:
        return redirect("insertrelease")

@app.route('/update')
def updateForm():
    if not checkAdmin():
        return redirect('/denied')
    
    if request.args.get('artist_id') is not None:
    ### ARTISTS
        artist = Artist.query.get(request.args.get('artist_id'))
        if artist is None:
            return redirect('artists')
        else:
            songs = [x.song_id for x in artist.songs]
            songsAvailable = Song.query.filter(Song.song_id.not_in(songs)).all()
            return render_template("updateform.html", artist=artist, songsAvailable=songsAvailable)
    elif request.args.get('song_id') is not None:
    ### SONGS
        song = Song.query.get(request.args.get('song_id'))
        songArtists = [x.artist_id for x in song.artists]
        artistsAvailable = Artist.query.filter(Artist.artist_id.not_in(songArtists))
        if song is None:
            return redirect('songs')
        else:
            return render_template("updateform.html", song=song, artistsAvailable=artistsAvailable, songKeys=songKeys)
    elif request.args.get('sample_id') is not None:
    ### SAMPLES
        sample = Sample.query.get(request.args.get('sample_id'))
        if sample is None:
            return redirect('samples')
        else:
            song = Song.query.filter_by(source_id=sample.source_id).first()
            repo = Repo.query.filter_by(source_id=sample.source_id).first()
            otherSources = []
            on_songs_ids = [s.song_id for s in sample.on_songs]
            allSongs = Song.query.filter(Song.song_id.not_in(on_songs_ids))
            # can probably make this prettier
            otherSongs = []
            for s in allSongs:
                for a in s.artists:
                    if a.artist_id == 1:
                        otherSongs.append(s)
            if song is not None:
                source = song.title
                for s in Song.query.all():
                    if s.source_id != song.source_id:
                        otherSources.append(s)
                for r in Repo.query.all():
                    otherSources.append(r)
            elif repo is not None:
                source = repo.name
                for s in Song.query.all():
                    otherSources.append(s)
                for r in Repo.query.all():
                    if r.source_id != repo.source_id:
                        otherSources.append(r)
            else:
                # TODO: Check if this goes against ER/DB design
                source = None
                for s in Song.query.all():
                    otherSources.append(s)
                for r in Repo.query.all():
                    otherSources.append(r)
            
            return render_template("updateform.html", 
                                   sample=sample, 
                                   source=source, 
                                   otherSources=otherSources,
                                   songsAvailable=otherSongs)
    elif request.args.get('UPC') is not None:
    ### RELEASES
        release = Release.query.get(request.args.get('UPC'))
        if release is None:
            return redirect('/')
        else:
            otherSongs = Song.query.filter(Song.song_id.not_in([s.song_id for s in release.songs]))
            return render_template("updateform.html", release=release, otherSongs=otherSongs)
    elif request.args.get('source_id') is not None:
    ### REPOS
        repo = Repo.query.get(request.args.get('source_id'))
        if repo is None:
            return redirect('repo')
        else:
            return render_template("updateform.html", repo=repo)
    else:
        return redirect("/")

@app.route('/delete')
def delete():
    if not checkAdmin():
        return redirect('/denied')
    # Blocks multiple item deletion (would rather dbms cascading deletes handle that)
    if len(request.args) > 1:
        return redirect("/")

    if request.args.get('song_id'):
        song = Song.query.get(request.args.get('song_id'))
        db.session.delete(song)
        db.session.commit()
        return redirect('songs')
    elif request.args.get('artist_id'):
        artist = Artist.query.get(request.args.get('artist_id'))
        db.session.delete(artist)
        db.session.commit()
        return redirect('artists')
    elif request.args.get('sample_id'):
        sample = Sample.query.get(request.args.get('sample_id'))
        db.session.delete(sample)
        db.session.commit()
        return redirect('samples')
    elif request.args.get('UPC'):
        release = Release.query.get(request.args.get('UPC'))
        db.session.delete(release)
        db.session.commit()
        return redirect('release')
    elif request.args.get('source_id'):
        repo = Repo.query.get(request.args.get('source_id'))
        db.session.delete(repo)
        db.session.commit()
        return redirect('repo')
    else:
        return redirect('/')

if __name__ == '__main__':
    app.run(port=8080, debug=True, host="0.0.0.0")
