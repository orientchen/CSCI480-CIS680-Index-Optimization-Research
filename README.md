# CSCI 480 / CIS 680 — Advanced Databases
## Research Lab: Investigating Index Selectivity and Query Optimization

This is the starter repository for a MySQL research lab. **Undergraduate and graduate students complete the same requirements.** Read the full assignment in [project-instructions/Research_Lab_Project.pdf](project-instructions/Research_Lab_Project.pdf) before beginning. The PDF contains the grading rubric and final submission requirements.

**What is provided:** a working GitHub Codespaces environment, a synthetic dataset, and scripts to create and verify it.

**What you must implement:** your own SQL queries, B-tree index, controlled performance comparisons, independent experiment, and interpretation of the results. **The experimental SQL scripts are intentionally not provided.**

## 1. Start in GitHub Codespaces

1. Open this repository on GitHub and select **Code → Codespaces → Create codespace on main**.
2. Wait for setup to finish. MySQL is installed locally in the Codespace; initial setup may take a few minutes.
3. Open the Codespaces terminal and run the following commands in order.

### Step 1 — Verify MySQL

```bash
mysql --version
sudo mysql -e "SELECT VERSION();"
```

If the server is not running, start it and try again:

```bash
sudo service mysql start
sudo mysql -e "SELECT VERSION();"
```

### Step 2 — Create the research database

```bash
bash scripts/run-sql.sh sql/01_create_database.sql
```

### Step 3 — Generate the dataset

```bash
time bash scripts/run-sql.sh sql/02_generate_data.sql
```

This creates **500,000 synthetic student records**. **Do not rerun the generation script after collecting results:** it clears and rebuilds the `Students` table and may remove your experimental changes.

### Step 4 — Verify the dataset

```bash
bash scripts/run-sql.sh sql/03_verify_data.sql
```

The `Students` table contains `student_id`, `student_name`, `adm_year`, and `gpa`. Confirm this distribution:

| Admission year | Records | Percentage of table |
| --- | ---: | ---: |
| 2020 | 5,000 | 1% |
| 2021 | 45,000 | 9% |
| 2022 | 450,000 | 90% |
| **Total** | **500,000** | **100%** |

**The guided setup ends here.** The rest of the lab requires SQL that **you write yourself**.

## 2. Student implementation: SQL experiments

Create your own `.sql` files (for example, in `student-work/`) and run them with the supplied helper:

```bash
bash scripts/run-sql.sh student-work/your_script.sql
```

Replace `your_script.sql` with the name of a file **you created**. The helper executes SQL in the local MySQL server. Use `USE index_research;` at the beginning of your SQL files as appropriate, and end SQL statements with semicolons.

### Task A — Baseline queries **before** creating an index

Write SQL that:

1. Retrieves records from `Students` for **each** admission year: 2020, 2021, and 2022. Use the same query structure for all three years, changing only the year value.
2. Uses MySQL's `EXPLAIN ANALYZE` to inspect the actual execution plan for each query.
3. Records the access method, optimizer-estimated row count, actual row count, and measured execution time.
4. Executes each query **five times** and calculates its **median** execution time. Save representative execution-plan output.

**Important:** Finish and save these baseline measurements **before** creating a secondary index on `adm_year`. The primary key already exists; your task is to study the effect of an additional index.

### Task B — Create and evaluate a B-tree index

Write SQL that:

1. Creates a **secondary B-tree index** on `Students(adm_year)` with a meaningful index name.
2. Verifies that the index exists and identifies its indexed column and index type.
3. Repeats the **same three queries** from Task A with the index available.
4. Executes each query **five times**, records execution plans, and computes median times.
5. Compares before/after access methods and timings for the 1%, 9%, and 90% cases.

**Do not assume** that creating an index guarantees MySQL will use it or that an index is always faster. Discover what the optimizer actually does in your environment.

### Task C — Investigate the optimizer's access-method choices

Write SQL that compares **three strategies** for **each** admission year:

- **Optimizer-selected plan:** allow MySQL to choose the access method.
- **Forced-index plan:** use MySQL's `FORCE INDEX` hint to request your B-tree index.
- **Index-ignored plan:** use `IGNORE INDEX` to prevent use of that secondary index and examine the alternative access method.

For all **nine combinations** (3 years × 3 strategies):

1. Collect `EXPLAIN ANALYZE` output.
2. Run each combination **five times** and calculate its median execution time.
3. Record the chosen access method, estimated rows, actual rows, and timing.
4. Identify which strategy is fastest for each year and explain why the outcome may differ with the percentage of matching records.
5. Discuss any disagreement between the optimizer's estimated costs and the measured execution times. Consider the limitations of timing measurements and row-count estimates.

**You must write the SQL for these comparisons.** The repository does not include completed query or indexing scripts.

### Task D — Independent investigation

Formulate **one additional, testable research question** related to indexing, selectivity, or query optimization. State a hypothesis, design a controlled experiment, write the necessary SQL, collect repeated measurements, and interpret the evidence. Explain what variable you changed, what you kept constant, and whether your results support the hypothesis.

Use at least **two academic or authoritative technical sources** to support your discussion, as required by the assignment PDF. An unexpected result is acceptable if you explain it carefully.

## 3. Recording and interpreting results

Keep a clear experimental record. At minimum, your results should distinguish:

- **Year and selectivity:** 2020 (1%), 2021 (9%), 2022 (90%).
- **Condition:** no secondary index, index available, forced index, or ignored index, as applicable.
- **Execution plan:** access method and relevant estimated/actual row counts.
- **Timing:** five observed execution times and their median (in milliseconds).

Use the **final actual-time value** reported by the relevant `EXPLAIN ANALYZE` iterator as your timing measure; apply the same method consistently. These are observed query-plan execution times, not exact universal benchmarks. Report your environment and discuss potential effects of caching and run-to-run variability.

Your report should explain **why** the observed results make sense (or why they were surprising), not merely list SQL commands and screenshots.

## 4. Files in this repository

- `project-instructions/Research_Lab_Project.pdf` — complete assignment and grading rubric.
- `sql/01_create_database.sql` — creates the database and `Students` table.
- `sql/02_generate_data.sql` — populates 500,000 synthetic rows; rerunning resets the table.
- `sql/03_verify_data.sql` — verifies counts and distribution.
- `scripts/run-sql.sh` — executes a SQL file against local MySQL.
- `scripts/setup-mysql.sh` — installs MySQL during initial Codespaces setup.
- `student-work/README.md` — guidance for keeping student work private.
- `.devcontainer/devcontainer.json` — Codespaces environment configuration.

**Not included:** completed baseline-query, index-creation, or access-method-comparison SQL files. You are expected to create these yourself.

## 5. MySQL access and troubleshooting

This Codespace runs MySQL **locally in the development container**, not in a separate Docker MySQL server. The installed version may change with package updates.

```bash
mysql --version
sudo mysql -e "SELECT VERSION();"
```

If MySQL is stopped after resuming a Codespace:

```bash
sudo service mysql start
```

To open an interactive MySQL terminal:

```bash
sudo mysql
```

Exit with `exit;`. If a script fails, read the error and verify your setup before rerunning it. Do not blindly rerun the dataset-generation script or attempt to create an index that already exists. Ask your instructor before resetting an experiment you have started.

## 6. Submission

Submit your **report (PDF), student-written SQL file(s), representative execution-plan evidence, and brief presentation through Canvas**, following the assignment PDF. Your report should include your hypothesis, experimental method, results, interpretation, independent investigation, and references. **Do not push solutions or experimental results to this public starter repository.**

## 7. Codespaces usage and data safety

Stop your Codespace when not actively working (**Codespaces → Stop codespace**) to conserve your monthly quota. Stopping normally preserves the workspace and local MySQL data while the Codespace exists, but deleting or rebuilding the environment may remove database data. **Back up your SQL files, measurements, and report outside the Codespace regularly.** Do not delete your Codespace before exporting your work.
