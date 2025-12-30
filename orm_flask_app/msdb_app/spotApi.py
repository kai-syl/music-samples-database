import os, json
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials

# https://spotipy.readthedocs.io/en/2.25.1/

with open("./secrets.json") as f:
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

def get_artist_img(artist_uri):
    sp = spotipy.Spotify(client_credentials_manager=auth_manager)
    artist = sp.artist(artist_uri)
    return artist['images'][0]['url']

def artist_search(artist_name, limit=10):
    sp = spotipy.Spotify(client_credentials_manager=auth_manager)
    results = sp.search(q='artist:' + artist_name, type='artist')
    items = results['artists']['items']

    if len(items) > 0:
        artists = {}
        count = 0
        for artist in items:
            artists[artist['name']] = artist
            count += 1
            if count >= limit:
                break
        #print("Found artists:", artists)
        return artists
    else:
        return None
    
# Testing
if __name__ == "__main__":
    name = 'Bjork'
    info = artist_search(name, limit=1)
    if info is not None and name in info:
        print(info[name]['external_urls']['spotify'])
    else:
        print("Artist not found")