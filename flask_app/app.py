#! /usr/bin/python3

from flask import Flask, request, render_template
from samples_db import getConnection

app = Flask(__name__)

@app.route('/')
def home():
    output = render_template('home.html')
    return output

@app.route('/songformget')
def songFormGet():
    output = render_template('songFormGet.html')
    return output

@app.route('/songformpost')
def songFormPost():
    output = render_template('songFormPost.html')
    return output

@app.route('/gettable', methods=['GET'])
def renderTableGet():
    title = request.args.get('title')
    genre = request.args.get('genre')
    key = request.args.get('key')
    bpm = request.args.get('bpm')
    ISRC = request.args.get('ISRC')
    output = render_template('table.html', title=title, genre=genre, key=key, bpm=bpm, ISRC=ISRC)
    return output

@app.route('/posttable', methods=['POST'])
def renderTablePost():
    title = request.form.get('title')
    genre = request.form.get('genre')
    key = request.form.get('key')
    bpm = request.form.get('bpm')
    ISRC = request.form.get('ISRC')
    output = render_template('table.html', title=title, genre=genre, key=key, bpm=bpm, ISRC=ISRC)
    return output

@app.route('/songtable', methods=['GET'])
def showSongs():
    connection = getConnection()
    cursor = connection.cursor()

    # Get current values of the artist table
    cursor.execute("SELECT * from song")
    results = cursor.fetchall()
    cursor.close()
    connection.close()
    return render_template('songTable.html', collection=results)

#@app.route('/admin')
#def admin():
#    output = render_template('adminTest.html')
#    return output

if __name__ == '__main__':
    app.run(port=8080, debug=True, host='0.0.0.0')