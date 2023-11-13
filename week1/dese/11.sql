SELECT schools.name, per_pupil_expenditure, graduation_rates.graduated FROM schools JOIN expenditures ON schools.district_id = expenditures.district_id JOIN graduation_rates on schools.id = graduation_rates.school_id
ORDER BY per_pupil_expenditure DESC, schools.name;