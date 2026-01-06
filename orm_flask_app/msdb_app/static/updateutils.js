// udpateutils.js

function moveItems(direction, type) {
    if (type === 'songs') {
        available = 'songsAvailable';
    }
    else if (type === 'artists') {
        available = 'artistsAvailable';
    }
    else if (type === 'on_songs') {
        available = 'songsAvailable';
    }
    let addedSelect = document.getElementById(type);
    let availableSelect = document.getElementById(available);
    if (direction === 'left') {
        // move from typeAvailable to type
        let selected = Array.from(availableSelect.selectedOptions);
        selected.forEach(option => {
            addedSelect.appendChild(option);
            option.selected = false;
        });
    } else if (direction === 'right') {
        // move from type to typeAvailable
        let selected = Array.from(addedSelect.selectedOptions);
        selected.forEach(option => {
            availableSelect.appendChild(option);
            option.selected = false;
        });
    }
}

function selectAll(type) {
    let selectOptions = document.getElementById(type).options;
    for (let i = 0; i < selectOptions.length; i++) {
        selectOptions[i].selected = true;
    }
}

function validateSpotifyUrl(url, type) {
    if (type === 'release') {
        var pattern = /^https?:\/\/(open\.spotify\.com|play\.spotify\.com)\/(album)\/[a-zA-Z0-9]+/;
    }
    else if (type === 'artist') {
        var pattern = /^https?:\/\/(open\.spotify\.com|play\.spotify\.com)\/(artist)\/[a-zA-Z0-9]+/;
    }
    else if (type === 'song') {
        var pattern = /^https?:\/\/(open\.spotify\.com|play\.spotify\.com)\/(track)\/[a-zA-Z0-9]+/;
    }
    // const spotifyPattern = /^https?:\/\/(open\.spotify\.com|play\.spotify\.com)\/(track|album|artist|playlist)\/[a-zA-Z0-9]+/;
    if (!pattern.test(url.value)) {
        alert("Invalid Spotify URL. Please enter a valid URL.");
        
        return false;
    }
    else {
        return true;
    }
}

function showHideElements(elementIds) {
    elementIds.forEach(id => {
        // var label = document.querySelector("label[for='" + id + "']");
        var element = document.getElementById(id);
        if (element.style.display === "none" || element.style.display === "") {
            element.style.display = "block";
            // label.style.display = "block";
        } 
        else {
            element.style.display = "none";
            // label.style.display = "none";
        }
    });
}