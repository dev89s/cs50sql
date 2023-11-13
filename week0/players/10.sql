SELECT first_name, last_name, bats AS hits FROM players
WHERE final_game BETWEEN '2022-01-01' AND '2022-12-31'
AND hits = 'R'
ORDER BY first_name, last_name ;