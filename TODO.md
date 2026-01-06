## High Priority
- [x] Add input sanitization functionality for URLs
- Add logic for requiring either ISRC or Spotify URL in song insert form
- Update ER diagram
    - Add 'url' to song table
- [x] Add a section to songs showing which samples were used
- Standardize insert/update form so a billion code updates aren't needed for one change

## Medium Priority
- Apply input sanitization to song, artist URL inputs
    - Place this logic on backend
- Implement spotApi info for songs and artists
- [x] Add functionality to automatically add release info on song insert via spotApi
- Update style of 'Releases' page to match songs/artists pages
    - I like the selector
    - Create a template to include with Jinja2?
- Cron job to clean up session data

## Low Priority
- Add artist name to song selectors in update/insert forms
- Look into flask blueprints and defaults