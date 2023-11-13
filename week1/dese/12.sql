SELECT districts.name, per_pupil_expenditure, exemplary FROM expenditures
JOIN districts ON expenditures.district_id = districts.id
JOIN staff_evaluations ON districts.id = staff_evaluations.district_id
WHERE per_pupil_expenditure > (SELECT AVG(per_pupil_expenditure) FROM expenditures)
AND
exemplary > (SELECT AVG(exemplary) FROM staff_evaluations)
AND
districts.type = 'Public School District'
ORDER BY exemplary DESC, per_pupil_expenditure DESC;