USE index_research;

SELECT COUNT(*) AS total_students
FROM Students;

SELECT adm_year, COUNT(*) AS student_count
FROM Students
GROUP BY adm_year
ORDER BY adm_year;
