# CSCI 480 / CIS 680 — Advanced Databases
## Research Lab: Investigating Index Selectivity and Query Optimization

This is the starter repository for the guided MySQL research lab. **Undergraduate and graduate students complete the same requirements.** Read the full assignment in [project-instructions/Research_Lab_Project.pdf](project-instructions/Research_Lab_Project.pdf) before beginning.

## Start in GitHub Codespaces

1. Open this repository on GitHub and select **Code → Codespaces → Create codespace on main**.
2. Wait until the development environment finishes setting up. The Codespace installs MySQL locally during initial setup; this may take a few minutes.
3. Open **Terminal** in Codespaces and follow the commands below **in order**.

## Step-by-Step Codespaces Instructions

### Step 1 — Verify that MySQL is available

```bash
mysql --version
sudo mysql -e "SELECT VERSION();"
```

If the MySQL server is not running, start it and retry the version check:

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

This creates **500,000 synthetic student records**. **Warning:** Running this data-generation script again clears and rebuilds the `Students` table. Do not rerun it after you have started collecting experimental results unless you intend to reset the experiment.

### Step 4 — Verify the dataset

```bash
bash scripts/run-sql.sh sql/03_verify_data.sql
```

Check the expected admission-year distribution:

| Admission year | Records | Percentage |
| --- | ---: | ---: |
| 2020 | 5,000 | 1% |
| 2021 | 45,000 | 9% |
| 2022 | 450,000 | 90% |
| **Total** | **500,000** | **100%** |

### Step 5 — Measure performance before indexing

```bash
bash scripts/run-sql.sh sql/04_baseline_queries.sql
```

**Stop here and save your baseline results before creating the index.** The script executes the three example queries (2020, 2021, and 2022). Run the same command **five times** and record each query's access method, estimated rows, actual rows, and execution time from `EXPLAIN ANALYZE`. Report the **median** execution time for each query. Keep representative execution-plan output for your report.

### Step 6 — Create the B-tree index

```bash
bash scripts/run-sql.sh sql/05_create_index.sql
```

This creates the secondary B-tree index on `Students(adm_year)`. **Run this script only once**; running it again while the index exists will produce a duplicate-index error.

### Step 7 — Repeat the queries with the index available

```bash
bash scripts/run-sql.sh sql/04_baseline_queries.sql
```

Run the command **five times**. Record the access method and execution time for each admission year, then compute the median. Compare these results with Step 5. An available index does **not** guarantee that MySQL will use it or that it will be faster.

### Step 8 — Compare optimizer-selected, forced-index, and table-scan strategies

```bash
bash scripts/run-sql.sh sql/06_compare_access_methods.sql
```

This script uses the optimizer's default choice, `FORCE INDEX`, and `IGNORE INDEX` to investigate alternative access strategies. Repeat the experiment **five times**, record the results for each year and strategy, and compare median execution times. Explain any differences between optimizer estimates and actual measurements.

### Step 9 — Complete the independent investigation and report

Use the assignment PDF for the independent research question, evidence, report requirements, and grading rubric. The provided SQL files are **starter experiments**, not solutions or measured results. Save your own SQL, observations, and representative execution plans in your private work area.

## Files

- `project-instructions/Research_Lab_Project.pdf`: complete assignment and grading rubric.
- `sql/01_create_database.sql`: create the database and `Students` table.
- `sql/02_generate_data.sql`: populate 500,000 synthetic rows; **rerunning resets the table data**.
- `sql/03_verify_data.sql`: inspect row counts and distribution.
- `sql/04_baseline_queries.sql`: example queries to run before and after indexing.
- `sql/05_create_index.sql`: create the B-tree secondary index; **run once**.
- `sql/06_compare_access_methods.sql`: compare automatic, `FORCE INDEX`, and `IGNORE INDEX` access methods.
- `scripts/run-sql.sh`: execute a SQL file using the locally installed MySQL server.
- `scripts/setup-mysql.sh`: install and initialize MySQL during Codespaces setup.
- `student-work/README.md`: guidance for keeping student work private.
- `.devcontainer/devcontainer.json`: Codespaces environment configuration.

## MySQL access and troubleshooting

This Codespace uses **MySQL installed locally in the development container**, not a separate Docker MySQL server. The exact MySQL version may vary with package updates.

Check the server version:

```bash
mysql --version
sudo mysql -e "SELECT VERSION();"
```

Start the MySQL service if it is stopped (for example, after resuming a Codespace):

```bash
sudo service mysql start
```

Open an interactive MySQL terminal:

```bash
sudo mysql
```

Exit the MySQL prompt with `exit;`.

Optionally inspect the InnoDB buffer pool configuration:

```bash
sudo mysql -e "SHOW VARIABLES LIKE 'innodb_buffer_pool_size';"
```

If a script fails, check the error and verify that you completed the preceding steps. Do not rerun `05_create_index.sql` if the index already exists. If you need to start over, consult your instructor before resetting the database, because resetting will discard your experimental setup and results.

## Submission

Submit your **report (PDF), SQL file(s), representative execution-plan evidence, and brief presentation through Canvas**, as specified in the project PDF. Do not push answers to this public starter repository.

## Codespaces usage

Stop your Codespace when you are not actively working (**Codespaces → Stop codespace**) to conserve your monthly usage quota. Stopping a Codespace normally preserves its files and local MySQL data while the Codespace exists, but deleting or rebuilding the environment may remove database data. **Save your SQL files, measurements, and report outside the Codespace regularly.** Do not delete the Codespace before exporting your work.
