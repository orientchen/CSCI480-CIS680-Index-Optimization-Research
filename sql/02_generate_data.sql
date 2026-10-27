USE index_research;

CREATE TABLE IF NOT EXISTS Digits (
    n INT PRIMARY KEY
);

INSERT IGNORE INTO Digits (n)
VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);

-- Generates 500,000 records. Re-running this file replaces the prior generated rows.
TRUNCATE TABLE Students;

INSERT INTO Students (student_id, student_name, adm_year, gpa)
SELECT
    x.id,
    CONCAT('Student_', x.id),
    CASE
        WHEN x.id % 100 = 0 THEN 2020
        WHEN x.id % 10 = 0 THEN 2021
        ELSE 2022
    END,
    2.00 + (x.id % 201) / 100.0
FROM (
    SELECT
        a.n + 10*b.n + 100*c.n
        + 1000*d.n + 10000*e.n
        + 100000*f.n + 1 AS id
    FROM Digits a
    CROSS JOIN Digits b
    CROSS JOIN Digits c
    CROSS JOIN Digits d
    CROSS JOIN Digits e
    CROSS JOIN Digits f
) AS x
WHERE x.id <= 500000;
