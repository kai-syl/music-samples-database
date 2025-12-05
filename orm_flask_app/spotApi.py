import os, json
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

# https://spotipy.readthedocs.io/en/2.25.1/

with open('secrets.json') as f:
    creds = json.load(f)['spot_api_credentials']

os.environ["SPOTIPY_CLIENT_ID"] = creds['client_id']
os.environ["SPOTIPY_CLIENT_SECRET"] = creds['client_secret']
auth_manager = SpotifyClientCredentials()

def get_albums(artist_uri):
    sp = spotipy.Spotify(client_credentials_manager=auth_manager)
    results = sp.artist_albums(artist_uri, album_type='single')
    albums = results['items']
    while results['next']:
        results = sp.next(results)
        albums.extend(results['items'])
    
    for album in albums:
        print('Album:', album['name'])

def get_album_cover(album_uri):
    sp = spotipy.Spotify(client_credentials_manager=auth_manager)
    album = sp.album(album_uri)
    return album['images'][0]['url']
