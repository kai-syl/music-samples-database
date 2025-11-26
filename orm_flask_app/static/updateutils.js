// udpateutils.js

function resetRemovalList(display) {
    document.getElementById(display+'sToRemove').value = '';
    document.getElementById(display+'sToRemoveDisplay').innerHTML = '';
    // reset name display for current artists:
    if (display === 'artist') {
    let artistDivs = document.querySelectorAll('[id^="artist_id["]');
    artistDivs.forEach(function(div) {
        let artist_id = div.id.match(/artist_id\[(\d+)\]/)[1];
        let artist_name = div.getAttribute('name');
        div.innerHTML = artist_name + ' <button type="button" id="deleteartist" onclick="removeButton({artist_id: \'' + artist_id + '\', artist_name: \''+ artist_name +'\'})">Remove</button>';
    });
}
    if (display === 'song') {
        let songDivs = document.querySelectorAll('[id^="song_id["]');
        songDivs.forEach(function(div) {
        let song_id = div.id.match(/song_id\[(\d+)\]/)[1];
        let song_title = div.getAttribute('name');
        div.innerHTML = song_title + ' <button type="button" id="deletesong" onclick="removeButton({song_id: \'' + song_id + '\', song_title: \''+ song_title +'\'})">Remove</button>';
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
            let currentDisplay = document.getElementById('artistsToRemoveDisplay').innerHTML;
            if (currentDisplay === '(none)') {
                document.getElementById('artistsToRemoveDisplay').innerHTML = artist_name;
            } else {
                document.getElementById('artistsToRemoveDisplay').innerHTML += artist_name + '<br/>';
            }
        }
    }
    if (song_id !== undefined) {
        document.getElementById('song_id[' + song_id + ']').innerHTML = song_title + ' (removing)';
        
        if (document.getElementById('songsToRemove').value.includes(song_id)) {
            return; // already marked for removal
        }
        else {
            document.getElementById('songsToRemove').value += song_id + ',';
            let currentSongDisplay = document.getElementById('songsToRemoveDisplay').innerHTML;
            if (currentSongDisplay === '(none)') {
                document.getElementById('songsToRemoveDisplay').innerHTML = song_title;
            } else {
                document.getElementById('songsToRemoveDisplay').innerHTML += song_title + '<br/>';
            }
        }
    }

}
