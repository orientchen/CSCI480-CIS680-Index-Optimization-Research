USE index_research;

-- Run AFTER creating idx_students_adm_year.
-- Repeat each condition five times; compare medians and inspect actual plans.
-- 2020
EXPLAIN ANALYZE SELECT * FROM Students WHERE adm_year = 2020;
EXPLAIN ANALYZE SELECT * FROM Students FORCE INDEX (idx_students_adm_year) WHERE adm_year = 2020;
EXPLAIN ANALYZE SELECT * FROM Students IGNORE INDEX (idx_students_adm_year) WHERE adm_year = 2020;

-- 2021
EXPLAIN ANALYZE SELECT * FROM Students WHERE adm_year = 2021;
EXPLAIN ANALYZE SELECT * FROM Students FORCE INDEX (idx_students_adm_year) WHERE adm_year = 2021;
EXPLAIN ANALYZE SELECT * FROM Students IGNORE INDEX (idx_students_adm_year) WHERE adm_year = 2021;

-- 2022
EXPLAIN ANALYZE SELECT * FROM Students WHERE adm_year = 2022;
EXPLAIN ANALYZE SELECT * FROM Students FORCE INDEX (idx_students_adm_year) WHERE adm_year = 2022;
EXPLAIN ANALYZE SELECT * FROM Students IGNORE INDEX (idx_students_adm_year) WHERE adm_year = 2022;
