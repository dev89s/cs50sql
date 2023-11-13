.import --csv meteorites.csv temp

-- changing empty fields to NULL
UPDATE "temp"
SET
    "mass" = NULL
WHERE
    "mass" = '';

UPDATE "temp"
SET
    "year" = NULL
WHERE
    "year" = '';

UPDATE "temp"
SET
    "lat" = NULL
WHERE
    "lat" = '';

UPDATE "temp"
SET
    "long" = NULL
WHERE
    "long" = '';

-- round the decimal numbers to nearest hundredths (2 digit after decimal)
UPDATE "temp"
SET
    "mass" = ROUND("mass", 2);

UPDATE "temp"
SET
    "lat" = ROUND("lat", 2);

UPDATE "temp"
SET
    "long" = ROUND("long", 2);

-- delete rows that has nametype "Relicts"
DELETE FROM "temp"
WHERE
    "nametype" = 'Relict';

-- create meteorite table
CREATE TABLE
    "meteorites" (
        "id" INTEGER,
        "name" TEXT NOT NULL,
        "class" TEXT NOT NULL,
        "mass" REAL,
        "discovery" TEXT NOT NULL CHECK ("discovery" IN ('Fell', 'Found')),
        "year" INTEGER,
        "lat" REAL,
        "long" REAL,
        PRIMARY KEY ("id")
    );

-- insert data from temp into meteorites and sort by year and name in ascending order
INSERT INTO
    "meteorites" (
        "name",
        "class",
        "mass",
        "discovery",
        "year",
        "lat",
        "long"
    )
SELECT
    "name",
    "class",
    "mass",
    "discovery",
    "year",
    "lat",
    "long"
FROM
    "temp"
ORDER BY
    "year",
    "name";