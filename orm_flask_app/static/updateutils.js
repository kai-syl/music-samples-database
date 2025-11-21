// udpateutils.js

function resetRemovalList(valueToReset='all') {
    if (valueToReset === 'all') {
        document.getElementById('artistsToRemove').value = '';
        document.getElementById('artistsToRemoveDisplay').innerHTML = '';
        // reset name display for current artists:
        let artistDivs = document.querySelectorAll('[id^="artist_id["]');
        artistDivs.forEach(function(div) {
            let artist_id = div.id.match(/artist_id\[(\d+)\]/)[1];
            let artist_name = div.getAttribute('name');
            div.innerHTML = artist_name + ' <button type="button" id="deleteartist" onclick="removeButton(\'' + artist_id + '\', \'' + artist_name + '\')">Remove</button>';
        });
    }
    else {
        let artist_id = valueToReset;
        let allArtists = document.getElementById('artistsToRemove').value;
        let updatedArtists = allArtists.replace(artist_id + ',', '');
        document.getElementById('artistsToRemove').value = updatedArtists;
        // Update display:
    }
}

function removeButton(artist_id, artist_name) {
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
