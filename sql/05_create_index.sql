
USE index_research;

-- Run after recording baseline results.
-- Explicitly create a B-tree index on the admission-year column.
CREATE INDEX idx_students_adm_year
USING BTREE
ON Students(adm_year);

-- Update table and index statistics for the query optimizer.
ANALYZE TABLE Students;

-- Verify that the index was created and its type is BTREE.
SHOW INDEX FROM Students;

-- Re-run sql/04_baseline_queries.sql to measure
-- optimizer choices with the B-tree index available.
