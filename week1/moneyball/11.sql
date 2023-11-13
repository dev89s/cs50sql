SELECT
    first_name,
    last_name,
    salary / H AS "dollars per hit"
FROM
    salaries
    JOIN players ON salaries.player_id = players.id
    JOIN performances ON players.id = performances.player_id
WHERE
    salaries.year = performances.year
    AND salaries.year = 2001
    AND performances.H != 0
ORDER BY
    "dollars per hit" ASC
LIMIT
    10;