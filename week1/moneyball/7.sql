SELECT
    first_name,
    last_name
FROM
    players
    JOIN salaries ON player_id = players.id
WHERE
    salary = (
        SELECT
            MAX(SALARY)
        FROM
            salaries
    );