-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- INSERTION QUERIES
INSERT INTO
    "Artist" ("band_name", "first_name", "last_name", "birth_date")
VALUES
    (NULL, 'Mustafa', 'Sandal', '1970-01-11'),
    (NULL, 'Andranik', 'Madadian', '1958-04-22'),
    ('Sting', 'Gordon', 'Sumner', '1951-10-02');

INSERT INTO
    "Song" ("song_name", "genre", "length")
VALUES
    ('Shape Of My Heart', 'Rock', 278),
    ('Aya Benzer', 'Pop', 280),
    ('Detay', 'Pop', 215);

UPDATE "Song"
SET
    "genre" = 'Pop'
WHERE
    "song_name" = 'Shape Of My Heart'
    AND "genre" = 'Rock';

DELETE FROM "Song"
WHERE
    "song_name" = "Detay"
    AND "length" = 215;

-- See album names of a certain artist orderd from latest to oldest
SELECT
    "first_name" || " " || "last_name" AS "artist_name",
    "album_name",
    "release_date"
FROM
    "Artist"
    JOIN "Produced" ON "Artist"."id" = "Produced"."artist_id"
    JOIN "Album" ON "Album"."id" = "Produced"."album_id"
WHERE
    "first_name" = "[artist_fist_name_here]" AND "last_name" = "[artist_last_name_here]"
ORDER BY
    "release_date" DESC;

-- See the most played song of a certain artist (uses a view)
SELECT
    "song_name",
    "play_count"
FROM
    "most_played_songs"
WHERE
    "artist_name" = "[artist_name_here]";
