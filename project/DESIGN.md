# Design Document

By **Sasan Moshirabadi**

Video overview:
[Link](https://www.youtube.com/watch?v=Cf7PgglM_Io)


## Scope

This database is designed for a music platform like spotify where the user can search
for songs, albums, play songs, create playlists, search for playlists, like songs,
rate songs (1-5 stars), etc.
This is the informational database and does not include the storage of the song files
or cover photos.

The involved people and things inlcude:

1. Artists, as in single artists.
2. Music albums.
3. Individual Songs.
4. Record Label companies.
5. Users

The musical history of any artist or music band is out of the scope of this database.
Also, there is no information about the different instrument players in a band.

## Functional Requirements

The user can retrieve the following information:

1. User can search for certain artist info.
2. User can search for songs of a certain artist having filters of time
3. User can search for albums of a specific artist
4. User can search for highly rated songs of an artist
5. User can search for songs that a specific user has liked
6. User can search for playlists that a specific user has created and the songs in
the play list.
7. User can search for albums
8. User can search for the record label of an album

This is the informational database and does not include the music files and
cover photos.

## Representation

### Entities

The `Entities` in the database includes Artists, Users, Songs, Albums, Playlists and, label records.
It also keeps track of songs played, rated tracks, and the Creators of the a song
('Songwriter', 'Singer', 'Composer').

#### Attributes

1. Artists: band_name, first_name, last_name, birth_date, artist_bio
2. User: username, password, first_name, last_name
3. Song: song_name, genre, length, rate (1, 2, 3, 4 and, 5 starts)
4. Album: album_name, release_date, type ("Single/EP", "Full Album"), publisher_id (FK)
5. Playlist: playlist_name, created_at (datetime), creator_id (foreign key)
6. Record Label: name, address, foundation (date)

There are some joined tables namely:

1. Created: Has foreign keys for song and artist
2. Rated: rate for single track from single user (1, 2, 3, 4 and, 5 starts), user_id, song_id
3. Played: user_id, song_id, play_datetime (timestamp)

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

This is the `Entity Relationship Diagram` for the database:
![ERD](./ERD.svg)
The list of `Entities` goes as follow:

 1. Artist:
    - *Created*: Introduces a joined table to for creation of a song and has a role field
    - *Subscribed*: Many to many relationship. Users can subscribe to artists
 2. User:
    - *Liked*: The user can like a song
    - *Rated*: A joined table for rating single tracks
    - *Played*: A joined table to keep record of played tracks by single user (datetime)
    - *Created*: Keeps record of the creation of a playlist by a user
    - *Followed*:Keeps record of the users folloiwing a playlist
    - *Subscirbed*
3. Song:
    - *Playlist_songs*: Songs that are included in a specific playlist
    - *Album_songs*: Songs that are included in a specific album
    - *Liked*
    - *Rated*
    - *Played*
    - *Created*
4. Album:
    - *Publised*: The Record_label company that has published the album
    - *Album_songs*
5. Record_lable:
    - *Published*

## Optimizations

### Indexes

The indexes that were added to the database come as follows:

1. Indexes were added to the Artist table one by the order: `first_name`, `last_name`,
and the other by the order: `last_name`, `first_name`. The table would be searched by
first_name, last_name and vice versa.
2. Add indexes `artist_album_index` to `Produced` table and `artist_song_index` to
`Song_created` table. This increases the spead of queries that would search for albums
and songs that were created by a specific Artist.
3. `album_release_index` and `song_index` where created on `Album` and `Song` tables
to speed up the searches maded based on `release_date` of an album and searches queries
made by song_name.
4. To speed up "rate" related queries the `user_rated_index` was created on `Song` table which
will increase the queries by `rate` and `song_name` to look for highest rated songs by a user.
Also, `rated_songs_index` was created on `Song` to speed up queries for finding highest rated
songs by `rate` and `song_id`.
5. An index on `Played` table was made to speed up queries that would count the number of plays
on specific song by specific user.
6. `liked_song_index` was created on `Liked` table to speed up queries that look for liked songs
by a specific user.
7. `playlist_name_index` and `playlist_user_index` was created on `Playlist` and `Playlist_followed`
tables to speed up queries that look for playlists that have been created or followed by a
specific user.

### Views

1. `likes` view to see the like count of `songs` ordered by `song_name`
2. `user_play_counts` to see the play count of a `songs` by different `users`
3. `song_release_date` to see the release date of `songs` ordered by `song_name`

## Limitations

The database represents only data for the entities to be connected. If you want to implement
a service, there should be other databases that store the songs and cover images and also
a proper login desgin.
The Artist/Band data is pretty limited. It could have a more detailed implementation with
more tables, including different performers in the band with connection to albums, songs, etc.
Also due to limited Artist/Band information and the `Created` table, it can provide inaccurate
information. Many connections between different artists and a certain song is needed to be created
and that's not the best way to implement it.
Also, the connection between Artist and Album should have the same amount of details.
