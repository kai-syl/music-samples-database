// udpateutils.js

function resetRemovalList(display) {
    document.getElementById(display+'sToRemove').value = '';
    // document.getElementById(display+'sToRemoveDisplay').innerHTML = '';
    // reset name display for current artists:
    if (display === 'artist') {
    let artistDivs = document.querySelectorAll('[id^="artist_id["]');
    artistDivs.forEach(function(div) {
        let artist_id = div.id.match(/artist_id\[(\d+)\]/)[1];
        let artist_name = div.getAttribute('name');
        div.innerHTML = '<button type="button" id="deleteartist" onclick="removeButton({artist_id: \'' + artist_id + '\', artist_name: \''+ artist_name +'\'})">Remove</button> ' + artist_name;
    });
}
    if (display === 'song') {
        let songDivs = document.querySelectorAll('[id^="song_id["]');
        songDivs.forEach(function(div) {
        let song_id = div.id.match(/song_id\[(\d+)\]/)[1];
        let song_title = div.getAttribute('name');
        div.innerHTML = '<button type="button" id="deletesong" onclick="removeButton({song_id: \'' + song_id + '\', song_title: \''+ song_title +'\'})">Remove</button> ' + song_title;
    });
    }
}

function removeButton({artist_id, artist_name, song_id, song_title = undefined}) {
    if (artist_id !== undefined) {
        document.getElementById('artist_id[' + artist_id + ']').innerHTML = artist_name + ' (removing)';
        if (document.getElementById('artistsToRemove').value.includes(artist_id)) {
            return; // already marked for removal
        }
        else {
            document.getElementById('artistsToRemove').value += artist_id + ',';
        }
    }
    if (song_id !== undefined) {
        document.getElementById('song_id[' + song_id + ']').innerHTML = song_title + ' (removing)';
        
        if (document.getElementById('songsToRemove').value.includes(song_id)) {
            return; // already marked for removal
        }
        else {
            document.getElementById('songsToRemove').value += song_id + ',';
        }
    }

}

// TODO: needs revamped to the same functionality as moveSongs
function addArtist({artist_id, artist_name}) {
    let addArtistDisplay = document.getElementById('addArtistDisplay');
    addArtistDisplay.innerHTML += '<br/>' + artist_name;
    document.getElementById('artistsToAdd').value += artist_id + ',';
}

function moveSongs(direction) {
    let songsSelect = document.getElementById('songs');
    let songsAvailableSelect = document.getElementById('songsAvailable');
    if (direction === 'left') {
        // move from songsAvailable to songs
        let selected = Array.from(songsAvailableSelect.selectedOptions);
        selected.forEach(option => {
            songsSelect.appendChild(option);
            option.selected = false;
        });
    } else if (direction === 'right') {
        // move from songs to songsAvailable
        let selected = Array.from(songsSelect.selectedOptions);
        selected.forEach(option => {
            songsAvailableSelect.appendChild(option);
            option.selected = false;
        });
    }
}

function selectAllSongs() {
    let songsSelectOptions = document.getElementById('songs').options;
    for (let i = 0; i < songsSelectOptions.length; i++) {
        songsSelectOptions[i].selected = true;
    }
}