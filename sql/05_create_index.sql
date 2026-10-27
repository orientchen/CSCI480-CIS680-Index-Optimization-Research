USE index_research;

-- Run after recording baseline results.
CREATE INDEX idx_students_adm_year ON Students(adm_year);
ANALYZE TABLE Students;

-- Re-run sql/04_baseline_queries.sql to measure optimizer choices with the index available.
