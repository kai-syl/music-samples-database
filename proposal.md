# proposal

# Description

Project for CSCI 240 Databases & SQL


The database will serve to describe the audio samples I've used in my electronically produced music, attributes of which include the sample's artist, genre, original release date, medium, and the source from which I sampled the audio.  


# Entity Sets

* Type: Sample
  * Instances:
  * Attributes: Genre, artist, source, release, release date, sample use/type? (i.e., drum loop, vocal, melody), medium
* Type: Sample's artist
  * Instances: SG Lewis, Sam Gellaitry, Ley Soul, Tash Sultana
  * Attributes: Name
* Type: Sample's 'release' (the album, single, EP, etc.)
  * Instances: Anemoia, Flow State
* Type: Song sample is featured on
  * Instances: Name 1, name 2, name 3, name 4
  * Attributes: Length, status of released or not released 

# Use cases

* To get the stats for which genres I've sampled the most/least
* To count how many times I've sampled an artist
* To count how many samples are on any given song I've created