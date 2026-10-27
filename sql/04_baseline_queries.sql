USE index_research;

-- Run BEFORE sql/05_create_index.sql to collect the no-secondary-index baseline.
-- Repeat each EXPLAIN ANALYZE five times; record results in your own worksheet.
EXPLAIN ANALYZE
SELECT * FROM Students WHERE adm_year = 2020;

EXPLAIN ANALYZE
SELECT * FROM Students WHERE adm_year = 2021;

EXPLAIN ANALYZE
SELECT * FROM Students WHERE adm_year = 2022;
