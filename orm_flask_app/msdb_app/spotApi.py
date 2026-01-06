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

def get_song_ISRC(track_url):
    sp = spotipy.Spotify(client_credentials_manager=auth_manager)
    track = sp.track(track_url)
    return track['external_ids']['isrc']

def get_album_info(album_url):
    sp = spotipy.Spotify(client_credentials_manager=auth_manager)
    album = sp.album(album_url)
    # return album['external_ids']['upc']
    return album

def get_song_info(track_url):
    sp = spotipy.Spotify(client_credentials_manager=auth_manager)
    track = sp.track(track_url)
    return track


# Testing
if __name__ == "__main__":
    # name = 'Bjork'
    # info = artist_search(name, limit=1)
    # if info is not None and name in info:
    #     print(info[name]['external_urls']['spotify'])
    # else:
    #     print("Artist not found")
    url = "https://open.spotify.com/album/3kse3e9XxmIedJb9bfjErH?si=9500e41cbbd749f1"
    
    album = get_album_info(url)
    
    track_url = "https://open.spotify.com/track/0fwktLgGSjgVieYm6JkA7R?si=2282d81c247342ea"
    track = get_song_info(track_url)

    # print(json.dumps(track, indent=2))
    # print(json.dumps(album, indent=2))
