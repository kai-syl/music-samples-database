import dbFunctions

options = """
1) Print Songs
2) Print Releases
3) Print releases a song appears on
4) Print songs on a release
5) Add a song to a release
6) Remove a song from a release
q) Quit

Do: """

quit = ''
while quit != 'q':
    quit = input(options)
    if quit == '1':
        dbFunctions.printTable('song')
    elif quit == '2':
        dbFunctions.printTable('`release`')
    elif quit == '3':
        dbFunctions.showReleasesWithSong()
    elif quit == '4':
        dbFunctions.showSongsOnRelease()
    elif quit == '5':
        dbFunctions.releaseAddSong()
    elif quit == '6':
        dbFunctions.releaseDropSong()
    elif quit == 'q':
        print("Goodbye")
    else:
        print("Invalid option")