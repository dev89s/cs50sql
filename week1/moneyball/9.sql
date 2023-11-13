SELECT
    name,
    ROUND(AVG(salary)) AS "average salary"
FROM
    salaries
    JOIN teams ON teams.id = salaries.team_id
WHERE
    salaries.YEAR = 2001
GROUP BY
    name
ORDER BY
    "average salary"
    LIMIT 5;