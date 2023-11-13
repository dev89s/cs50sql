SELECT name from schools JOIN graduation_rates ON school_id = schools.id
WHERE graduated = 100;