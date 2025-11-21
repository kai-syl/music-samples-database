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
        print(removeList)
        for id in removeList:
            if id == '' or id is None:
                continue
            artist = Artist.query.get(id)
            #song.artists.remove(artist)
            updateArtist_Song('drop', artist, song)

    db.session.commit()
    return redirect(f'read?t=song&song_id={song_id}')

### Multi-use pages depending on GET variables
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
    return output

@app.route('/updateform')
def updateArtistForm():
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
    else:
        return redirect("/")

@app.route('/delete')
def delete():
    if request.args.get('song_id') is not None and request.args.get('artist_id') is None:
        song = Song.query.get(request.args.get('song_id'))
        db.session.delete(song)
        db.session.commit()
        return redirect('read?t=song')
    elif request.args.get('artist_id') is not None and request.args.get('song_id') is None:
        artist = Artist.query.get(request.args.get('artist_id'))
        db.session.delete(artist)
        db.session.commit()
        return redirect('read?t=artist')

if __name__ == '__main__':
    app.run(port=8080, debug=True, host="0.0.0.0")
