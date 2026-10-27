# CSCI 480 / CIS 680 — Advanced Databases
## Research Lab: Investigating Index Selectivity and Query Optimization

This repository provides the GitHub Codespaces environment and dataset for the **guided experimental investigation** in Advanced Databases. **Undergraduate and graduate students complete the same requirements.**

**The original six-page assignment posted on Canvas is the official project description.** Read it before beginning. A copy is also available at [project-instructions/Research_Lab_Project.pdf](project-instructions/Research_Lab_Project.pdf). If the repository copy differs from the original Canvas assignment, follow the original Canvas assignment and ask your instructor about any discrepancy.

**What is provided:** A Codespaces environment with local MySQL, scripts to create and verify the 500,000-record dataset, and SQL examples in the official assignment PDF for the guided experiments.

**What you do:** Execute and adapt the SQL examples from the PDF, collect and compare measurements, interpret MySQL execution plans, design an independent experiment, and communicate evidence-based conclusions. The experimental SQL files are not prewritten in this repository; you may create your own `.sql` files using the examples in the PDF.

## 1. Start in GitHub Codespaces

1. Open this repository on GitHub and choose **Code → Codespaces → Create codespace on main**.
2. Wait for the environment setup to finish. MySQL is installed locally in the Codespace; initial setup may take a few minutes.
3. Open the terminal and follow the setup commands below in order.

### Step 1 — Verify MySQL

```bash
mysql --version
sudo mysql -e "SELECT VERSION();"
```

If MySQL is not running:

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

This creates **500,000 synthetic student records**. **Do not rerun this script after starting experiments:** it rebuilds the `Students` table and can remove indexes or other changes you have made.

### Step 4 — Verify the dataset

```bash
bash scripts/run-sql.sh sql/03_verify_data.sql
```

The `Students` table has `student_id`, `student_name`, `adm_year`, and `gpa`. Verify the expected distribution:

| Admission year | Records | Percentage of table |
| --- | ---: | ---: |
| 2020 | 5,000 | 1% |
| 2021 | 45,000 | 9% |
| 2022 | 450,000 | 90% |
| **Total** | **500,000** | **100%** |

## 2. Conduct the guided experiments (Parts 2–4 of the PDF)

**Use the SQL examples and instructions in the original assignment PDF.** You do not need to invent the baseline queries, index-creation statement, or index-hint syntax from scratch. However, you must run the experiments yourself, document what happened, and explain the results.

To run SQL that you place in your own file, use:

```bash
bash scripts/run-sql.sh student-work/your_script.sql
```

Replace `your_script.sql` with your actual filename. Begin your file with `USE index_research;` as appropriate, and end SQL statements with semicolons. You can also execute SQL interactively using `sudo mysql`.

### Part 2 — Baseline: no secondary index (15 points)

Use the three `EXPLAIN ANALYZE` examples in **Part 2 of the PDF** for admission years 2020, 2021, and 2022. For each query:

- Record the access method, actual rows returned, and execution time.
- **Run each query five times** and use the **median execution time**.
- Save representative execution plans and explain the behavior of queries with different numbers of matching records.

**Finish and save these results before creating the secondary index.**

### Part 3 — Create an index and repeat (20 points)

Follow **Part 3 of the PDF** to create the B-tree index on `Students(adm_year)` and update table statistics. Then repeat the same three queries, **five times each**, and compare median execution times and access methods with Part 2.

Create the index **only once**. If it already exists, rerunning its creation statement will produce an error. Do not assume the index will always be selected or always improve performance.

### Part 4 — Compare alternative strategies (20 points)

Use the `FORCE INDEX` and `IGNORE INDEX` examples in **Part 4 of the PDF**, adapting the admission-year value for 2020, 2021, and 2022. Compare these strategies with MySQL's automatic choice.

For each of the **nine combinations** (three years × three strategies), run the query **five times** and record the median execution time. Verify the actual access method shown in `EXPLAIN ANALYZE`, rather than assuming a hint guarantees a particular plan. Explain which strategy performs best in your measurements and why.

## 3. Independent research experiment (Part 5 — 20 points)

**This is the part you must design yourself.** The PDF suggests possible directions such as table size, covering indexes, and range queries, and includes illustrative SQL. These are starting points, **not completed independent experiments**.

You must:

1. Choose a specific, testable research question and state a hypothesis before testing.
2. Explain what variable you will change and what conditions you will keep consistent.
3. Write or adapt the SQL necessary to conduct the experiment.
4. Collect measurements and evidence from execution plans.
5. Interpret whether the evidence supports your hypothesis and discuss at least one limitation.

You may use one of the directions suggested in the PDF or propose another relevant investigation. A single example query without a research design, comparison, and analysis is not sufficient.

## 4. Research background and final report (Part 6 — 15 points)

Follow **Part 6 of the original PDF**. Use at least **two relevant academic or technical sources**, including **at least one research paper or scholarly publication**.

Prepare a **4–6 page report** (excluding SQL code and detailed execution output) covering your research question, background, methodology, results, interpretation, limitations, conclusion, and references. Include completed result tables, representative execution-plan evidence, and **at least one chart**.

Your work will be evaluated on the correctness of your experimental procedure, the quality of your analysis, and the evidence supporting your conclusions—not on whether a particular index improves performance. Unexpected results are acceptable when carefully investigated.

## 5. Recording and interpreting measurements

For each applicable experiment, retain:

- The admission year and percentage of matching records.
- The query and access strategy used.
- The execution plan and relevant row counts.
- Five execution-time measurements and their median.
- A concise explanation of the observed differences and possible limitations.

For consistency, use the final `actual time` value from the relevant `EXPLAIN ANALYZE` iterator as the measured execution time. Timing may vary because of caching and other activity; avoid running unrelated resource-intensive programs while measuring. Record your MySQL version and Codespaces configuration.

## 6. Repository files

- `project-instructions/Research_Lab_Project.pdf` — copy of the original project assignment; the original PDF posted on Canvas is authoritative.
- `sql/01_create_database.sql` — creates the database and `Students` table.
- `sql/02_generate_data.sql` — generates 500,000 records; rerunning rebuilds the table.
- `sql/03_verify_data.sql` — checks record counts and admission-year distribution.
- `scripts/run-sql.sh` — executes a SQL file against local MySQL.
- `scripts/setup-mysql.sh` — installs MySQL during initial Codespaces setup.
- `student-work/README.md` — guidance on keeping student work private.
- `.devcontainer/devcontainer.json` — Codespaces configuration.

**Not included:** `04_baseline_queries.sql`, `05_create_index.sql`, and `06_compare_access_methods.sql`. These separate scripts are unnecessary because the official PDF already contains SQL examples for Parts 2–4. You may create your own files to organize and run those examples.

## 7. MySQL access and troubleshooting

MySQL runs **locally in the development container**, not in a separate Docker MySQL server.

```bash
mysql --version
sudo mysql -e "SELECT VERSION();"
```

If the service has stopped after resuming Codespaces:

```bash
sudo service mysql start
```

For an interactive MySQL session:

```bash
sudo mysql
```

Exit the MySQL prompt with `exit;`. Read errors carefully before rerunning scripts. If you need to reset an experiment after collecting results, ask your instructor first.

## 8. Submission

Submit through **Canvas**, as required by the original assignment PDF:

- A PDF research report with experimental results and analysis.
- A `.sql` file containing the SQL statements used in your experiments.
- Representative execution-plan evidence (screenshots or copied text).
- A brief presentation summarizing the research question, methodology, findings, and conclusions.

**Do not push your solutions or results to this public starter repository.**

## 9. Codespaces usage and data safety

Stop your Codespace when you are not actively working (**Codespaces → Stop codespace**) to conserve your monthly usage quota. Stopping normally preserves files and local MySQL data while the Codespace exists, but rebuilding or deleting the environment may remove database data. **Back up your SQL files, measurements, and report outside Codespaces regularly.** Do not delete your Codespace before exporting your work.
