# CSCI 480 / CIS 680 — Advanced Databases
## Research Lab: Investigating Index Selectivity and Query Optimization

This is the starter repository for the guided MySQL research lab. **Undergraduate and graduate students complete the same requirements.** Read the full assignment in [project-instructions/Research_Lab_Project.pdf](project-instructions/Research_Lab_Project.pdf).

## Start in GitHub Codespaces

1. Open this repository on GitHub, select **Code → Codespaces → Create codespace on main**.
2. Wait for the development container to finish setting up. It starts a MySQL 8.4 Docker container automatically. The first startup may take a few minutes.
3. In the Codespaces terminal, run the scripts **in order**:

```bash
bash scripts/run-sql.sh sql/01_create_database.sql
bash scripts/run-sql.sh sql/02_generate_data.sql
bash scripts/run-sql.sh sql/03_verify_data.sql
bash scripts/run-sql.sh sql/04_baseline_queries.sql
```

**Stop and record baseline results before proceeding.** Repeat the three baseline queries five times each, recording times and access methods. Running `04_baseline_queries.sql` again executes all three queries once more.

4. Then create the index and investigate indexed queries:

```bash
bash scripts/run-sql.sh sql/05_create_index.sql
bash scripts/run-sql.sh sql/04_baseline_queries.sql
bash scripts/run-sql.sh sql/06_compare_access_methods.sql
```

Repeat experiments as required by the PDF, and complete your own independent investigation. The provided SQL files contain **starter queries, not solutions or measured results**.

## Files

- `project-instructions/Research_Lab_Project.pdf`: complete assignment and grading rubric.
- `sql/01_create_database.sql`: create the database and Students table.
- `sql/02_generate_data.sql`: populate 500,000 synthetic rows; **re-running clears and rebuilds Students**.
- `sql/03_verify_data.sql`: inspect counts and distribution.
- `sql/04_baseline_queries.sql`: three example queries; run before and after indexing.
- `sql/05_create_index.sql`: create the secondary index; run **once** (running it twice without dropping the index will cause an error).
- `sql/06_compare_access_methods.sql`: compare optimizer, FORCE INDEX, and IGNORE INDEX strategies.
- `student-work/README.md`: guidance for private student work.
- `.devcontainer/`, `compose.yaml`, `scripts/`: Codespaces MySQL environment and runner.

## MySQL access and troubleshooting

The setup uses a local Docker MySQL 8.4 server. To start it manually if needed:

```bash
bash scripts/start-mysql.sh
```

To open an interactive MySQL terminal:

```bash
docker exec -it index-research-mysql mysql -uroot -pprojectroot
```

The root password `projectroot` is **only for this disposable educational database**. Do not reuse it for any personal or production database. The container is not configured to expose MySQL to the public internet.

To see MySQL version:

```bash
docker exec index-research-mysql mysql -uroot -pprojectroot -e 'SELECT VERSION();'
```

If a query fails, read the error and confirm that you ran the scripts in order. Avoid rerunning `05_create_index.sql` once the index exists.

## Submission

Submit your report (PDF), SQL file(s), representative execution-plan evidence, and brief presentation **through Canvas**, as specified in the project PDF. Do not push answers to this public starter repository.

## Codespaces usage

Stop your Codespace when you are not actively working (**Codespaces → Stop codespace**) to conserve your monthly quota. Stopping the Codespace preserves its files and Docker volume while the Codespace still exists. Do not delete the Codespace before exporting your work; deleted Codespaces may lose their database data.
