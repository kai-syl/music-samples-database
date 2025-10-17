### Simple menu script
import mysql.connector, os

def getConnection():
	connection = mysql.connector.connect(
		host=os.environ['SQL_HOST'],
		user=os.environ['SQL_USER'],
		password=os.environ['SQL_PWD'],
		db=os.environ['SQL_DB']
	)
	return connection

def printTable(table):
		connection = getConnection()
		cursor = connection.cursor()
		try:
			cursor.execute(f"select * from {table}")
			result = cursor.fetchone()
		except (mysql.connector.Error) as e:
			print(e)
			connection.close()
			print("Try again.")
			return None

		print(f"In the {table} table, we have the following records: ")
		while result is not None:
			print(result)
			result = cursor.fetchone()
		connection.close()
		print()

def insertIntoTable():
	title = str(input("Insert into the song table. \nTitle: "))
	genre = str(input("Genre: "))
	key = str(input("Key: "))
	bpm = int(input("BPM: "))
	isrc = str(input("ISRC: "))
	query = f"""insert into song (`title`, `genre`, `key`, `bpm`, `ISRC`)
		values ('{title}', '{genre}', '{key}', {bpm}, '{isrc}')"""

	connection = getConnection()
	cursor = connection.cursor()
	try:
		cursor.execute(query)
		connection.commit()
		connection.close()
		print(f"Successfully entered '{title}' into song table")
	except (mysql.connector.Error) as e:
		print(e)
		print("Try again")

def deleteRowFromTable():
	rowToDelete = int(input("Song ID to delete from song: "))
	connection = getConnection()
	cursor = connection.cursor()
	try:
		cursor.execute(f"select * from song where song_id={rowToDelete}")
		result = cursor.fetchone()
		if result is None:
			connection.close()
			print(f"Song with song ID [{rowToDelete}] doesn't exist")
			return None
		else:
			title = result[2]
		
		confirm = input(f"Are you sure you want to delete '{title}' [{rowToDelete}] from song table?(y/n) ")
		if confirm == 'y':
			try:
				cursor.execute(f"delete from song where song_id={rowToDelete}")
				connection.commit()
				connection.close()
				print(f"Successfully deleted {title} [{rowToDelete}]")
				return None
			except (mysql.connector.Error) as e:
				print(e)
		else:
			connection.close()
			print("Operation aborted")
	except (mysql.connector.Error) as e:
		print(e)
		print("Try again")
	connection.close()

def updateRow():
	rowToUpdate = int(input("ID of row to update in song table: "))
	connection = getConnection()
	cursor = connection.cursor()

	try:
		cursor.execute(f"select * from song where song_id={rowToUpdate}")
		result = cursor.fetchone()
		if result is None:
			print(f"Song with song ID [{rowToUpdate}] doesn't exist")
			connection.close()
			return None
		else:
			print(f"Song [{rowToUpdate}] values: \n{result}")
			title = str(input(f"Updating song [{rowToUpdate}]\nTitle: "))
			genre = str(input("Genre: "))
			key = str(input("Key: "))
			bpm = int(input("BPM: "))
			isrc = str(input("ISRC: "))
			query = f"""update song set title='{title}', genre='{genre}', `key`='{key}',
			bpm={bpm}, ISRC='{isrc}' where song_id={rowToUpdate}
			"""
			try:
				cursor.execute(query)
				connection.commit()
				connection.close()
				print(f"Successfully updated song [{rowToUpdate}]")
			except (mysql.connector.Error) as e:
				print(e)
				print("Failed to update record")
	except (mysql.connector.Error) as e:
		print(e)
		print("Operation aborted")
	connection.close()

def showReleasesWithSong (song_id=None):
	### Shows all the releases a song is listed on
	if song_id == None:
		song_id = input("Song ID: ")
	
	connection = getConnection()
	cursor = connection.cursor()

	query = f"""select r.title, r.type, r.releaseDate, r.UPC
	from `release` as r
	where r.UPC in (
		select UPC
		from release_song
		where song_id = {song_id}
		);"""
	try:
		if checkNoneResult(f"select title from song where song_id={song_id}") == True:
			print(f'Song ID [{song_id}] not found in database')
			connection.close()
			return None
		else:
			cursor.execute(f"select title from song where song_id={song_id}")
			songTitle = cursor.fetchall()[0][0]
			cursor.execute(query)
			result = cursor.fetchone()
		if result is not None:
			print(f"'{songTitle}' appears on the following releases:")
		else:
			print(f"'{songTitle}' does not appear on any releases in the database.")

		while result is not None:
			print(f"\n{result[0]}\n  Type: {result[1]}\n  Release Date: {result[2]}")
			result = cursor.fetchone()
		connection.close()
	except (mysql.connector.Error) as e:
		print(e)
		connection.close()
		print(f"Error while executing showReleasesWithSong({song_id})")

def showSongsOnRelease (releaseTitle=None):
	### Shows all the songs listed on a release
	if releaseTitle == None:
		releaseTitle = input("Release title: ")
	
	connection = getConnection()
	cursor = connection.cursor()

	try:
		UPC = getUPC(releaseTitle)
		if UPC is None:
			connection.close()
			return None
		sorQuery = f"""select s.title
		from `song` as s
		where s.ISRC in (
			select ISRC
			from release_song
			where UPC = {UPC}
			);"""
		cursor.execute(sorQuery)
		songTitle = cursor.fetchone()
		print(f'The following songs are listed on {releaseTitle} and in the database: ')
		while songTitle is not None:
			print(f'  {songTitle[0]}')
			songTitle = cursor.fetchone()
		connection.close()
	except (mysql.connector.Error) as e:
		print(e)
		connection.close()
		print("Try again")

def releaseAddSong (releaseTitle=None, song_id=None):
	### Adds a song to a release
	connection = getConnection()
	cursor = connection.cursor()
	if song_id == None:
		song_id = input("Song ID to add to release: ")
	if checkNoneResult(f"select title from song where song_id={song_id}") == True:
			print(f'Song ID [{song_id}] not found in database')
			connection.close()
			return None
	else:
		cursor.execute(f'select title from song where song_id={song_id}')
		songTitle = cursor.fetchone()[0]
	if releaseTitle == None:
		releaseTitle = input(f"Title of release to add {songTitle} to: ")
	
	UPC = getUPC(releaseTitle)
	ISRC = getISRC(song_id)
	if ISRC is None:
		print(f"'{songTitle}' doesn't have an ISRC. Can't add to '{releaseTitle}'")
		connection.close()
		return None

	query = f"""insert into release_song (`UPC`, `ISRC`, `song_id`) 
	values ({UPC}, '{ISRC}', {song_id})"""
	try:
		cursor.execute(query)
		connection.commit()
		connection.close()
		print(f"Successfully added Song ID [{song_id}] to '{releaseTitle}'")
	except (mysql.connector.Error) as e:
		print(e)
		print("Error while executing releaseAddSong()")
		connection.close()

def releaseDropSong (releaseTitle=None, song_id=None):
	### Deletes a song from a release
	connection = getConnection()
	cursor = connection.cursor()
	if song_id == None:
		song_id = input("Song ID to drop from release: ")
	
	query = f"select title from song where song_id = {song_id};"
	try:
		cursor.execute(query)
		songTitle = cursor.fetchone()
		if songTitle is None:
			print(f"No song with song ID [{song_id}]")
			connection.close()
			return None
		else:
			songTitle = songTitle[0]
	except (mysql.connector.Error) as e:
		print(e)
		print("Error while getting songTitle for releaseDropSong")
		connection.close()
		return None

	if releaseTitle == None:
		releaseTitle = input(f"Title of release to drop {songTitle} from: ")
	
	UPC = getUPC(releaseTitle)
	ISRC = getISRC(song_id)

	if UPC is None:
		connection.close()
		return None
	
	query = f"select * from release_song where UPC = {UPC} and ISRC = '{ISRC}';"
	try:
		cursor.execute(query)
		if cursor.fetchone() is None:
			print(f"'{songTitle}' isn't a part of the '{releaseTitle}' release.")
			connection.close()
			return None
	except (mysql.connector.Error) as e:
		print(e)
		print(f"Error while checking '{releaseTitle}' for '{songTitle}'")
		connection.close()
		return None

	query = f"delete from release_song where UPC = {UPC} and ISRC = '{ISRC}';"
	confirm = input(f"Are you sure you want to delete '{songTitle}' from '{releaseTitle}'?(y/n) ")
	if confirm == 'y':
		try:
			cursor.execute(query)
			connection.commit()
			print(f"Successfully dropped '{songTitle}' from '{releaseTitle}'")
		except (mysql.connector.Error) as e:
			print(e)
			print("Error while executing releaseDropSong()")
			connection.close()
			return None
	else:
		print("Operation aborted.")
	
	connection.close()
 
def getISRC(song_id):
	### Gets song ISRC and song_id
	connection = getConnection()
	cursor = connection.cursor()
	iQuery = f"select ISRC from song where song_id = {song_id}"

	try:
		if checkNoneResult(iQuery) == True:
			print(f"Song ID [{song_id}] doesn't exist in the database or ISRC isn't entered")
			connection.close()
			return None
		else:
			if checkMultipleResults(iQuery) == True:
				cursor.execute(iQuery)
				cResult = cursor.fetchone()
				while cResult is not None:
					print(f'{cResult[2]}\n  ISRC: {cResult[0]}\n  Song ID: {cResult[1]}')
					cResult = cursor.fetchone()
				song_id = input('Please clarify which song you want (song ID): ')
				cursor.execute(f'select ISRC from song where song_id = {song_id}')
				ISRC = cursor.fetchone()
			else:
				cursor.execute(f'select ISRC from song where song_id = {song_id}')
				ISRC = cursor.fetchone()[0]
			connection.close()
			return ISRC
	except (mysql.connector.Error) as e:
		print(e)
		print(f"Error while executing getISRC({song_id})")
		connection.close()


def getUPC(releaseTitle):
	### Gets release UPC 
	connection = getConnection()
	cursor = connection.cursor()
	query = f"select * from `release` where title = '{releaseTitle}';"
	uQuery = f"select UPC from `release` where title = '{releaseTitle}';"

	if checkNoneResult(query) == True:
		print(f"'{releaseTitle}' doesn't exist in the database")
		connection.close()
		return None
	
	try:
		if checkMultipleResults(uQuery) == True:
			cursor.execute(query)
			cResult = cursor.fetchone()
			while cResult is not None:
				print(f'{cResult}')
				cResult = cursor.fetchone()
			UPC = input("Please clarify which release you want (UPC): ")
		else:
			cursor.execute(uQuery)
			UPC = cursor.fetchone()[0]
			connection.close()
			return UPC
	except (mysql.connector.Error) as e:
		print(e)
		print(f"Error while executing getUPC({releaseTitle})")
		connection.close()

def checkNoneResult(query):
	### Checks that a query returns data (True) or None (False)
	connection = getConnection()
	cursor = connection.cursor()
	try:
		cursor.execute(query)
		result = cursor.fetchone()
		connection.close()
		if result is None or result[0] == '':
			return True
		else:
			return False
	except (mysql.connector.Error) as e:
		connection.close()
		print(e)
		print(f"Error while executing checkNoneResult({query})")

def checkMultipleResults(query):
	### Checks if a query returns multiple results (True) or 0-1 results (False)
	connection = getConnection()
	cursor = connection.cursor()
	try:
		cursor.execute(query)
		numRows = 0
		while numRows != 2:
			try:
				row = cursor.fetchone()
				if row is not None:
					numRows += 1
				else:
					break
			except (mysql.connector.Error) as e:
				print(e)
				connection.close()
				return None
		if numRows < 2:
			connection.close()
			return False
		elif numRows == 2:
			connection.close()
			return True
	except (mysql.connector.Error) as e:
		connection.close()
		print(e)
		return None


if __name__ == "__main__":
	options = """
1) Display contents of a table
2) Insert new row to a table
3) Update a row of table
4) Delete a row of table
q) Quit

Do: """
	quit = ''
	while quit != 'q':
		quit = input(options)
		if quit == '1':
			table = input("Table: ")
			printTable(table)
		elif quit == '2':
			insertIntoTable()
		elif quit == '3':
			updateRow()
		elif quit == '4':
			deleteRowFromTable()
		elif quit == 'q':
			print("Goodbye")
		else:
			print("Invalid option")

