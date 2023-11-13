SELECT
    dollars_per_hit.first_name,
    dollars_per_hit.last_name
FROM
    (
        SELECT
            players.id AS player_id,
            first_name,
            last_name,
            salary / H AS dollars_per_hit
        FROM
            players
            JOIN salaries ON salaries.player_id = players.id
            JOIN performances ON performances.player_id = players.id
        WHERE
            salaries.year = performances.year
            AND salaries.year = 2001
            AND H != 0
        ORDER BY
            dollars_per_hit ASC,
            first_name,
            last_name
        LIMIT
            10
    ) AS dollars_per_hit
    JOIN (
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
            dollars_per_rbi ASC,
            first_name,
            last_name
        LIMIT
            10
    ) AS dollars_per_rbi ON dollars_per_hit.player_id = dollars_per_rbi.player_id
    ORDER BY
        dollars_per_hit.player_id