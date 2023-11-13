SELECT schools.name, graduated FROM schools
JOIN graduation_rates ON schools.id = school_id
WHERE graduated > (SELECT AVG(graduated) FROM graduation_rates)
ORDER BY graduated DESC;