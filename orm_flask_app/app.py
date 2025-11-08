from flask import Flask, render_template, redirect, request
from flask_sqlalchemy import SQLAlchemy
import os

host=os.environ['SQL_HOST']
user=os.environ['SQL_USER']
password=os.environ['SQL_PWD']
db_name=os.environ['SQL_DB']
app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{user}:{password}@{host}/{db_name}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

class Artist(db.Model):
    artist_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String)
    nationality = db.Column(db.String)
    genre = db.Column(db.String)

class Song(db.Model):
    song_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    key = db.Column(db.String)
    bpm = db.Column(db.String)
    genre = db.Column(db.String)
    ISRC = db.Column(db.String)

@app.route('/')
def index():
    return render_template("home.html")

@app.route('/insertartist')
def insertArtistForm():
    return render_template("insertform.html", t="artist")

@app.route('/insertsong')
def insertSongForm():
    return render_template("insertform.html", t="song")

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

@app.route('/read')
def read():
    table = request.args.get('t')
    if table == 'song':
        songs = Song.query.all()
        output = render_template("showsongs.html", songs=songs)
    elif table == 'artist':
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
        if song is None:
            return redirect('read?t=song')
        else:
            return render_template("updateform.html", song=song)
    else:
        return redirect("/")


@app.route('/updateartist')
def updateArtist():
    artist = Artist.query.get(request.args.get('artist_id'))
    artist.name = request.args.get('name')
    artist.nationality = request.args.get('nationality')
    artist.genre = request.args.get('genre')
    db.session.commit()
    return redirect('read?t=artist')

@app.route('/updatesong')
def updateSong():
    song = Song.query.get(request.args.get('song_id'))
    song.title = request.args.get('title')
    song.key = request.args.get('key')
    song.genre = request.args.get('genre')
    song.bpm = request.args.get('bpm')
    song.ISRC = request.args.get('ISRC')
    db.session.commit()
    return redirect('read?t=song')

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
