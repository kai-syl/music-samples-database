### Database functions needed for flask app
import mysql.connector, os

def getConnection():
	connection = mysql.connector.connect(
		host=os.environ['SQL_HOST'],
		user=os.environ['SQL_USER'],
		password=os.environ['SQL_PWD'],
		db=os.environ['SQL_DB']
	)
	return connection
