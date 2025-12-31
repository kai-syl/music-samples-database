## High Priority
- Add input sanitization for URLs
- Add logic for requiring either ISRC or Spotify URL in song insert form
- Update ER diagram
    - Add 'url' to song table
- Add a section to songs showing which samples were used
- Standardize insert/update form so a billion code updates aren't needed for one change

## Medium Priority
- Add functionality to automatically add release info on song insert via spotApi
- Add 'Releases' section in artist page
- Update style of 'Releases' page to match songs/artists pages
    - I like the selector
- Cron job to clean up session data

## Low Priority
- Add artist name to song selectors in update/insert forms
- Look into flask blueprints and defaults