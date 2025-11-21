from extensions import db

artist_song = db.Table('artist_song',
    db.Column('artist_id', db.Integer, db.ForeignKey('artist.artist_id'), primary_key=True),
    db.Column('song_id', db.Integer, db.ForeignKey('song.song_id'), primary_key=True)
)

class Artist(db.Model):
    __tablename__ = 'artist'
    artist_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String)
    nationality = db.Column(db.String)
    genre = db.Column(db.String)

class Song(db.Model):
    __tablename__ = 'song'
    song_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String)
    key = db.Column(db.String)
    bpm = db.Column(db.String)
    genre = db.Column(db.String)
    ISRC = db.Column(db.String)
    artists = db.relationship("Artist", secondary=artist_song, backref='songs', lazy='dynamic')
