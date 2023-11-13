SELECT
    first_name,
    last_name,
    salary
FROM
    salaries
    JOIN players ON salaries.player_id = players.id
WHERE
    year = 2001
ORDER BY
    salary, first_name, last_name
LIMIT
    50;