-- In this SQL file, write (and comment!) the schema of your database, including
-- CREATE TABLE, CREATE INDEX , CREATE VIEW, etc. statements that compose it.

--------------------------------------------------------------------
--------------------------------------------------------------------
------------------------ Main Tables -------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

-- "Artist" Table
CREATE TABLE IF NOT EXISTS "Artist" (
    "id" INTEGER,
    "band_name" TEXT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "birth_date" DATE NOT NULL,
    "bio" TEXT,
    PRIMARY KEY("id")
);

-- "User" Table
CREATE TABLE IF NOT EXISTS "User" (
    "id" INTEGER,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    PRIMARY KEY("id")
);

-- "Playlist" Table
CREATE TABLE IF NOT EXISTS "Playlist" (
    "id" INTEGER,
    "playlist_name" TEXT NOT NULL,
    "created_at" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "creator_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("creator_id") REFERENCES "User"("id")
);

-- "Song" Table
CREATE TABLE IF NOT EXISTS "Song" (
    "id" INTEGER,
    "song_name" TEXT NOT NULL,
    "genre" TEXT NOT NULL,
    "length" INTEGER NOT NULL,
    "rate" INTEGER CHECK("rate" IN (0, 1, 2, 3, 4, 5)) DEFAULT 0,
    PRIMARY KEY("id")
);

-- "Record_label" Table
CREATE TABLE IF NOT EXISTS "Record_label" (
    "id" INTEGER,
    "name" TEXT,
    "address" TEXT,
    "foundation" DATE,
    PRIMARY KEY("id")
);

-- "Album" Table
CREATE TABLE IF NOT EXISTS "Album" (
    "id" INTEGER,
    "album_name" TEXT,
    "release_date" DATE,
    "type" TEXT CHECK("type" IN ("Single/EP", "Full Album")),
    "publisher_id" INTEGER,
    PRIMARY KEY("id"),
    FOREIGN KEY("publisher_id") REFERENCES "Record_label"("id")
);

--------------------------------------------------------------------
--------------------------------------------------------------------
-------------------- Many to Many Tables ---------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

-- "Created": Artist created the Song
CREATE TABLE IF NOT EXISTS "Created" (
    "artist_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("artist_id", "song_id"),
    FOREIGN KEY("artist_id") REFERENCES "Artist"("id"),
    FOREIGN KEY("song_id") REFERENCES "Song"("id")
);

-- "Produced": Artist produced the Album
CREATE TABLE IF NOT EXISTS "Produced" (
    "artist_id" INTEGER,
    "album_id" INTEGER,
    PRIMARY KEY("artist_id", "album_id"),
    FOREIGN KEY("artist_id") REFERENCES "Artist"("id"),
    FOREIGN KEY("album_id") REFERENCES "Album"("id")
);

-- "Subscribed": User subscirbed to Artist
CREATE TABLE IF NOT EXISTS "Subscribed" (
    "artist_id" INTEGER,
    "user_id" INTEGER,
    PRIMARY KEY("artist_id", "user_id"),
    FOREIGN KEY("artist_id") REFERENCES "Artist"("id"),
    FOREIGN KEY("user_id") REFERENCES "User"("id")
);

-- "Rated": User rated the Song
CREATE TABLE IF NOT EXISTS "Rated" (
    "id" INTEGER,
    "user_id" INTEGER,
    "song_id" INTEGER,
    "rate" INTEGER NOT NULL CHECK("rate" IN (1, 2, 3, 4, 5)),
    PRIMARY KEY("id"),
    FOREIGN KEY("user_id") REFERENCES "User"("id"),
    FOREIGN KEY("song_id") REFERENCES "Song"("id")
);

-- "Liked": User Liked the Song
CREATE TABLE IF NOT EXISTS "Liked" (
    "user_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("user_id", "song_id"),
    FOREIGN KEY("user_id") REFERENCES "User"("id"),
    FOREIGN KEY("song_id") REFERENCES "Song"("id")
);

-- "Played": User played the Song
CREATE TABLE IF NOT EXISTS "Played" (
    "user_id" INTEGER,
    "song_id" INTEGER,
    "play_datetime" DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY("song_id", "play_datetime"),
    FOREIGN KEY("user_id") REFERENCES "User"("id"),
    FOREIGN KEY("song_id") REFERENCES "Song"("id")
);

-- "Playlist_created": User followed the playlist
CREATE TABLE IF NOT EXISTS "Playlist_followed" (
    "user_id", INTEGER,
    "playlist_id" INTEGER,
    PRIMARY KEY("user_id", "playlist_id"),
    FOREIGN KEY("user_id") REFERENCES "User"("id"),
    FOREIGN KEY("playlist_id") REFERENCES "Playlist"("id")
);

-- "Playlist_song"
CREATE TABLE IF NOT EXISTS "Playlist_song" (
    "song_id" INTEGER,
    "playlist_Id" INTEGER,
    PRIMARY KEY("song_id", "playlist_id"),
    FOREIGN KEY("song_id") REFERENCES "Song"("id"),
    FOREIGN KEY("playlist_id") REFERENCES "Playlist"("id")
);

-- "Album_song"
CREATE TABLE IF NOT EXISTS "Album_song" (
    "album_id" INTEGER,
    "song_id" INTEGER,
    PRIMARY KEY("album_id", "song_id"),
    FOREIGN KEY("album_id") REFERENCES "Album"("id"),
    FOREIGN KEY("song_id") REFERENCES "Song"("id")
);

--------------------------------------------------------------------
--------------------------------------------------------------------
-------------------------- INDEXES ---------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

-- Create an index on Artist's first_name and last_name because
-- people will search the artist by its first name and last name
-- also an index on last_name and first_name.
CREATE INDEX IF NOT EXISTS "first_last_artist" ON "Artist" ("first_name", "last_name");
CREATE INDEX IF NOT EXISTS "last_first_artist" ON "Artist" ("last_name", "first_name");

-- Create an index on Produced And Created table because the user may
-- want to see all the albums and songs created by the artist
CREATE INDEX IF NOT EXISTS "artist_album_index" ON "Produced" ("arist_id", "album_id");
CREATE INDEX IF NOT EXISTS "artist_song_index" ON "Created" ("arist_id", "song_id");

-- Create a song_name index on Songs table and a release_date on Albums
-- Users may want to search for songs by name and year of release_date
CREATE INDEX IF NOT EXISTS "album_release_index" ON "Album" ("release_date");
CREATE INDEX IF NOT EXISTS "album_release_index" ON "Album" ("album_name");
CREATE INDEX IF NOT EXISTS "song_index" ON "Song" ("song_name");

-- Create an index on Rated table, because user may want to search for top rated
-- songs by specific artist or generally.
CREATE INDEX IF NOT EXISTS "user_rated_index" ON "Song" ("rate", "song_name") WHERE "rate" IN (4, 5);
CREATE INDEX IF NOT EXISTS "rated_songs_index" ON "Rated" ("rate", "song_id") WHERE "rate" IN (4, 5);

-- Create an index on Played table, because user may want to know which tracks
-- are played the most by a specific user.
CREATE INDEX IF NOT EXISTS "user_played_index" ON "Played" ("user_id", "song_id");


-- Create an index on Liked table. User may want to know which songs
-- have been liked by certain user.
CREATE INDEX IF NOT EXISTS "liked_song_index" ON "Liked" ("user_id", "song_id");

-- Create an index on playlist name, playlist_id, and user_id on Playlist and Playlist_followed.
-- User may want to search for playlists he has followed or created by name
CREATE INDEX IF NOT EXISTS "playlist_name_index" ON "Playlist" ("playlist_name");
CREATE INDEX IF NOT EXISTS "playlist_user_index" ON "Playlist_followed" ("user_id", "playlist_id");

-- The database could be further optimized but I thinkg this would saffice
-- for frequent usage of the database.


--------------------------------------------------------------------
--------------------------------------------------------------------
----------------------------- VIEWS --------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------

-- A view to see the like count of songs by song name
CREATE VIEW IF NOT EXISTS
    "likes" AS
SELECT
    COUNT("song_id") AS "like_count",
    "song_name"
FROM
    "Song"
    JOIN "Liked" ON "Song"."id" = "Liked"."song_id"
GROUP BY
    "song_name"
ORDER BY
    "song_name";

-- A view to see the play count of songs by different users
CREATE VIEW IF NOT EXISTS
    "user_play_counts" AS
SELECT
    "first_name" || " " || "last_name" AS "name",
    "song_name",
    COUNT("song_id") AS "play_count"
FROM
    "User"
    JOIN "Played" ON "Played"."user_id" = "User"."id"
    JOIN "Song" ON "Played"."song_id" = "Song"."id"
GROUP BY
    "song_id"
ORDER BY
    "last_name", "first_name";

-- See the most played songs of artists
CREATE VIEW IF NOT EXISTS
    "most_played_songs" AS
SELECT
    "first_name" || " " || "last_name" AS "artist_name",
    "song_name",
    COUNT("Played"."song_id") AS "play_count"
FROM
    "Played"
    JOIN "Song" ON "Played"."song_id" = "Song"."id"
    JOIN "Created" ON "Created"."song_id" = "Song"."id"
    JOIN "Artist" ON "Created"."artist_id" = "Artist"."id"
GROUP BY
    "Played"."song_id"
ORDER BY
    "play_count" DESC;

-- Release date of songs listed by song name
CREATE VIEW IF NOT EXISTS
    "song_release_date" AS
SELECT
    ROW_NUMBER() OVER (ORDER BY "song_name") AS "id",
    "song_name",
    strftime('%Y', "release_date") AS "year",
    "type" AS "release_type",
    "album_name"
FROM
    "Song"
    JOIN "Album_song" ON "Song"."id" = "Album_song"."song_id"
    JOIN "Album" ON "Album"."id" = "Album_song"."album_id"
ORDER BY "year"

