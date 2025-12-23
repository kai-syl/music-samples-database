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