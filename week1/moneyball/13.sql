SELECT
    players.id AS player_id,
    first_name,
    last_name,
    salary / H AS dollars_per_hi
FROM
    players
    JOIN salaries ON salaries.player_id = players.id
    JOIN performances ON performances.player_id = players.id
WHERE
    salaries.year = performances.year
    AND salaries.year = 2001
    AND H != 0
ORDER BY
    dollars_per_hi ASC
LIMIT
    10;

SELECT
    players.id AS player_id,
    first_name,
    last_name,
    salary / RBI AS dollars_per_rbi
FROM
    players
    JOIN salaries ON salaries.player_id = players.id
    JOIN performances ON performances.player_id = players.id
WHERE
    salaries.year = performances.year
    AND salaries.year = 2001
    AND RBI != 0
ORDER BY
    dollars_per_rbi ASC
LIMIT
    10;