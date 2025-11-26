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
				return None
		else:
			connection.close()
			print("Operation aborted")
			return None
	except (mysql.connector.Error) as e:
		print(e)
		print("Try again")

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


options = """
1) Display contents of a table
2) Insert new row to a table
3) Update a row of table
4) Delete a row of table
q) Quit

Do: """

if __name__ == "__main__":
	quit = ''
	while quit != 'q':
		quit = input(options)
		if quit == '1':
			table = input("Table: ")q
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

