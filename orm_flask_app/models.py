from extensions import db

artist_song = db.Table('artist_song',
    db.Column('artist_id', db.Integer, db.ForeignKey('artist.artist_id'), primary_key=True),
    db.Column('song_id', db.Integer, db.ForeignKey('song.song_id'), primary_key=True)
)

# Relationship showing which samples are used (by me) on which songs
sample_on_song = db.Table('sample_on_song',
    db.Column('sample_id', db.Integer, db.ForeignKey('sample.sample_id'), primary_key=True),
    db.Column('song_id', db.Integer, db.ForeignKey('song.song_id'), primary_key=True)
)

# Many-to-many relationship for songs on releases
release_song = db.Table('release_song',
    db.Column('UPC', db.Integer, db.ForeignKey('release.UPC'), primary_key=True),
    db.Column('ISRC', db.String, db.ForeignKey('song.ISRC'), primary_key=True),
    #db.Column('song_id', db.Integer, db.ForeignKey('song.song_id'))
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
    source_id = db.Column(db.Integer, db.ForeignKey('sampleSource.source_id'))
    title = db.Column(db.String)
    key = db.Column(db.String)
    bpm = db.Column(db.String)
    genre = db.Column(db.String)
    ISRC = db.Column(db.String)
    artists = db.relationship("Artist", secondary=artist_song, backref='songs', lazy='dynamic')
    #releases = db.relationship('Release', secondary=release_song, backref='songs', lazy='dynamic')

class SampleSource(db.Model):
    __tablename__ = 'sampleSource'
    source_id = db.Column(db.Integer, primary_key=True)

class Sample(db.Model):
    __tablename__ = 'sample'
    sample_id = db.Column(db.Integer, primary_key=True)
    instrument = db.Column(db.String)
    genre = db.Column(db.String)
    source_id = db.Column(db.Integer, db.ForeignKey('sampleSource.source_id'))
    on_songs = db.relationship("Song", secondary=sample_on_song, backref='samplesUsed', lazy='dynamic')

class Repo(db.Model):
    __tablename__ = 'repo'
    source_id = db.Column(db.Integer, db.ForeignKey('sampleSource.source_id'), primary_key=True)
    custodian = db.Column(db.String)
    type = db.Column(db.String)
    price = db.Column(db.Float)
    billed = db.Column(db.String)
    name = db.Column(db.String)

class Release(db.Model):
    __tablename__ = 'release'
    UPC = db.Column(db.Integer, primary_key=True)
    type = db.Column(db.String)
    releaseDate = db.Column(db.DateTime)
    numSongs = db.Column(db.Integer)
    title = db.Column(db.String)
    songs = db.relationship('Song', secondary=release_song, backref='releases', lazy='dynamic')


