from datetime import datetime
from flask import Flask, render_template, redirect, request
from flask_sqlalchemy import SQLAlchemy
import os
from extensions import db
from models import *

host=os.environ['SQL_HOST']
user=os.environ['SQL_USER']
password=os.environ['SQL_PWD']
db_name=os.environ['SQL_DB']

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{user}:{password}@{host}/{db_name}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

def updateArtist_Song(action, artist, song):
    if action == 'insert':
        song.artists.append(artist)
    elif action == 'drop':
        song.artists.remove(artist)
    else:
        pass

@app.route('/')
def index():
    return render_template("home.html")

### Artists
@app.route('/insertartist')
def insertArtistForm():
    return render_template("insertform.html", t="artist")

@app.route('/newartist')
def insertArtist():
    if request.args.get('name') is not None:
        artist = Artist(
            name=request.args.get("name"), 
            nationality=request.args.get("nationality"), 
            genre=request.args.get("genre")
        )
        db.session.add(artist)
        db.session.commit()
        return redirect("read?t=artist")
    else:
        return redirect("insertartist")
    
@app.route('/updateartist')
def updateArtist():
    artist = Artist.query.get(request.args.get('artist_id'))
    artist.name = request.args.get('name')
    artist.nationality = request.args.get('nationality')
    artist.genre = request.args.get('genre')
    db.session.commit()
    return redirect('read?t=artist')

### Songs
@app.route('/insertsong')
def insertSongForm():
    return render_template("insertform.html", t="song")

@app.route('/newsong')
def insertSong():
    if request.args.get('title') is not None:
        song = Song(
            title = request.args.get('title'),
            key = request.args.get('key'),
            bpm = request.args.get('bpm'),
            genre = request.args.get('genre'),
            ISRC = request.args.get('ISRC')
        )
        db.session.add(song)
        db.session.commit()
        return redirect("read?t=song")
    
@app.route('/updatesong')
def updateSong():
    song_id = request.args.get('song_id')
    song = Song.query.get(song_id)
    song.title = request.args.get('title')
    song.key = request.args.get('key')
    song.genre = request.args.get('genre')
    song.bpm = request.args.get('bpm')
    song.ISRC = request.args.get('ISRC')
    artist_id = request.args.get('artist_id')
    
    # If artist ID not blank, add to artist_song
    if artist_id:
        artistToInsert = Artist.query.get(artist_id)
        updateArtist_Song('insert', artistToInsert, song)

    # If artistsToRemove not blank, remove from artist_song
    if request.args.get('artistsToRemove'):
        removeList = request.args.get('artistsToRemove').split(',')
        #print(removeList)
        for id in removeList:
            if id == '' or id is None:
                continue
            artist = Artist.query.get(id)
            #song.artists.remove(artist)
            updateArtist_Song('drop', artist, song)

    db.session.commit()
    return redirect(f'read?t=song&song_id={song_id}')

### Multi-use pages depending on GET variables
# Going to move away from this design later
@app.route('/read')
def read():
    table = request.args.get('t')
    song_id = request.args.get('song_id')
    artist_id = request.args.get('a')
    if table == 'song':
        if song_id is not None:
            song = Song.query.get(song_id)
            output = render_template("showsong.html", song=song)
        else:
            songs = Song.query.all()
            output = render_template("showsongs.html", songs=songs)
    elif table == 'artist':
        if artist_id is not None:
            artist = Artist.query.get(artist_id)
            output = render_template("showartist.html", artist=artist)
        else:
            artists = Artist.query.all()
            output = render_template("showartists.html", artists=artists)
    else:
        output = redirect("/")
    return output

# Samples and Repos

@app.route('/samples')
def showSamples():
    sample_id = request.args.get('sample_id')
    if sample_id:
        sample = Sample.query.get(sample_id)
        source_id = sample.source_id
        # check if sampleSource is a song or repo
        if Song.query.filter_by(source_id=source_id).first() is not None:
            song = Song.query.filter_by(source_id=source_id).first()
            return render_template("showsample.html", sample=sample, song=song)
        else:
            repo = Repo.query.filter_by(source_id=source_id).first()
            return render_template("showsample.html", sample=sample, repo=repo)

    else:
        samples = Sample.query.all()
        sources = {}
        for sample in samples:
            source_id = sample.source_id
            if Song.query.filter_by(source_id=source_id).first() is not None:
                song = Song.query.filter_by(source_id=source_id).first()
                sources[source_id] = {"link": "read?t=song&song_id=" + str(song.song_id), "name": song.title}
            else:
                repo = Repo.query.filter_by(source_id=source_id).first()
                sources[source_id] = {"link": "repo?id=" + str(repo.source_id), "name": repo.name}
        return render_template("showsamples.html", samples=samples, sources=sources)

@app.route('/repo')
def showRepos():
    source_id = request.args.get('id')
    if source_id:
        repo = Repo.query.get(source_id)
        return render_template("showrepo.html", repo=repo)
    else:
        repos = Repo.query.all()
        return render_template("showrepos.html", repos=repos)

@app.route('/insertsample')
def insertSampleForm():
    sources = []
    for s in Song.query.all():
        sources.append(s)
    for r in Repo.query.all():
        sources.append(r)
    
    # Get songs by artist 1 (me) for "used on" selection
    on_songs = Artist.query.get(1).songs
    return render_template("insertform.html", t="sample", sources=sources, on_songs=on_songs)

@app.route('/updatesample')
def updateSample():
    sample_id = request.args.get('sample_id')
    sample = Sample.query.get(sample_id)
    sample.instrument = request.args.get('instrument')
    sample.genre = request.args.get('genre')
    sample.source_id = request.args.get('source_id')
    song_id = request.args.get('song_id')

    if song_id:
        songToInsert = Song.query.get(song_id)
        sample.on_songs.append(songToInsert)

    # If songsToRemove not blank, remove from sample_on_song
    if request.args.get('songsToRemove'):
        removeList = request.args.get('songsToRemove').split(',')
        for id in removeList:
            if id == '' or id is None:
                continue
            song = Song.query.get(id)
            sample.on_songs.remove(song)

    db.session.commit()
    return redirect(f'samples?sample_id={sample_id}')

@app.route('/newsample')
def insertSample():
    sample = Sample(
        instrument=request.args.get('instrument'),
        genre=request.args.get('genre'),
        source_id=request.args.get('source_id')
    )
    song_id = request.args.get('song_id')
    if song_id:
        songToInsert = Song.query.get(song_id)
        sample.on_songs.append(songToInsert)
    db.session.add(sample)
    db.session.commit()
    return redirect(f'samples?sample_id={sample.sample_id}')

# Releases

@app.route('/release')
def showRelease():
    UPC = request.args.get('UPC')
    if UPC:
        release = Release.query.get(UPC)
        otherReleases = [r for r in Release.query.all() if r.UPC != release.UPC]
        return render_template("showrelease.html", release=release, otherReleases=otherReleases)
    else:
        otherReleases = Release.query.all()
        return render_template("showrelease.html", otherReleases=otherReleases)

@app.route('/updaterelease')
def updateRelease():
    UPC = request.args.get('UPC')
    if UPC:
        # This method allows for partial updates, but also still requires UPC (the primary key)
        attrs = request.args
        release = Release.query.get(UPC)
        if request.args.get('songsToRemove'):
            removeList = request.args.get('songsToRemove').split(',')
            for id in removeList:
                if id == '' or id is None:
                    continue
                song = Song.query.get(id)
                release.songs.remove(song)
        for i in request.args:
            if i == 'songsToRemove':
                continue
            elif i == 'song_id':
                song = Song.query.get(request.args.get('song_id'))
                if song:
                    release.songs.append(song)

            else:
                release.__setattr__(i, attrs[i])
        db.session.commit()
        return redirect(f'release?UPC={UPC}')
    else:
        return redirect('/release')

@app.route('/insertrelease')
def insertReleaseForm():
    return render_template("insertform.html", t="release")

@app.route('/newrelease')
def insertRelease():
    if request.args.get('UPC') is not None:
        release = Release(
            UPC=request.args.get('UPC'),
            title=request.args.get('title'),
            type=request.args.get('type'),
            numSongs=request.args.get('numSongs'),
            releaseDate=request.args.get('releaseDate')
        )
        db.session.add(release)
        db.session.commit()
        return redirect(f"release?UPC={release.UPC}")
    else:
        return redirect("insertrelease")

@app.route('/updateform')
def updateForm():
    if request.args.get('artist_id') is not None:
        artist = Artist.query.get(request.args.get('artist_id'))
        if artist is None:
            return redirect('read?t=artist')
        else:
            return render_template("updateform.html", artist=artist)
    elif request.args.get('song_id') is not None:
        song = Song.query.get(request.args.get('song_id'))
        songArtists = [x.artist_id for x in song.artists]
        otherArtists = Artist.query.filter(Artist.artist_id.not_in(songArtists))
        if song is None:
            return redirect('read?t=song')
        else:
            return render_template("updateform.html", song=song, otherArtists=otherArtists)
    elif request.args.get('sample_id') is not None:
        # Need to add "used on" selection removal
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
            
            return render_template("updateform.html", 
                                   sample=sample, 
                                   source=source, 
                                   otherSources=otherSources,
                                   otherSongs=otherSongs)
    elif request.args.get('UPC') is not None:
        release = Release.query.get(request.args.get('UPC'))
        if release is None:
            return redirect('/')
        else:
            otherSongs = Song.query.filter(Song.song_id.not_in([s.song_id for s in release.songs]))
            return render_template("updateform.html", release=release, otherSongs=otherSongs)
    else:
        return redirect("/")

@app.route('/delete')
def delete():
    # Blocks multiple item deletion (would rather dbms cascading deletes handle that)
    if len(request.args) > 1:
        return redirect("/")

    if request.args.get('song_id'):
        song = Song.query.get(request.args.get('song_id'))
        db.session.delete(song)
        db.session.commit()
        return redirect('read?t=song')
    elif request.args.get('artist_id'):
        artist = Artist.query.get(request.args.get('artist_id'))
        db.session.delete(artist)
        db.session.commit()
        return redirect('read?t=artist')
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
    else:
        return redirect('/')

if __name__ == '__main__':
    app.run(port=8080, debug=True, host="0.0.0.0")
