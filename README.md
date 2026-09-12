# Voltkart — Advanced SQL for Data Engineering

My implementation of the Voltkart Advanced SQL challenge from the Codebasics Data Engineering Bootcamp.

## Skills & Concepts

- SQL Server / T-SQL
- Joins and subqueries
- Window functions
- CTEs
- Recursive CTEs
- Data warehousing concepts
- MERGE for incremental data loading
- Change Data Capture (CDC)
- Query optimization
- SARGable predicates
- Execution plan analysis

## Solutions

The `sql` folder contains my solutions for all 11 questions, including the bonus question.

| Question | SQL File |
|---|---|
| Q1 | [Q1.sql](sql/Q1.sql) |
| Q2 | [Q2.sql](sql/Q2.sql) |
| Q3 | [Q3.sql](sql/Q3.sql) |
| Q4 | [Q4.sql](sql/Q4.sql) |
| Q5 | [Q5.sql](sql/Q5.sql) |
| Q6 | [Q6.sql](sql/Q6.sql) |
| Q7 | [Q7.sql](sql/Q7.sql) |
| Q8 | [Q8.sql](sql/Q8.sql) |
| Q9 | [Q9.sql](sql/Q9.sql) |
| Q10 | [Q10.sql](sql/Q10.sql) |
| Q11 — Bonus | [Q11.sql](sql/Q11.sql) |

## Q10 — Query Optimization

Q10 focuses on optimizing a slow customer lifetime-value query.

The optimization included:

- Replacing a correlated subquery with a CTE.
- Replacing `YEAR(order_date)` with a SARGable date range.
- Adding nonclustered indexes.
- Comparing execution plans and `SET STATISTICS IO` before and after optimization.

### Performance

| Metric | Before | After |
|---|---:|---:|
| Logical Reads | 653 | 195 |
| CPU Time | 78 ms | 31 ms |
| Rows Returned | 1,965 | 1,965 |

Detailed execution-plan and statistics evidence is available in [`optimization/Q10`](optimization/Q10).

## Repository Structure

```text
voltkart-advanced-sql-data-engineering/
│
├── sql/
│   ├── Q1.sql
│   ├── Q2.sql
│   ├── Q3.sql
│   ├── Q4.sql
│   ├── Q5.sql
│   ├── Q6.sql
│   ├── Q7.sql
│   ├── Q8.sql
│   ├── Q9.sql
│   ├── Q10.sql
│   └── Q11.sql
│
├── optimization/
│   └── Q10/
│       ├── README.md
│       ├── before_execution_plan.png
│       ├── before_statistics_io.png
│       ├── after_execution_plan.png
│       └── after_statistics_io.png
│
└── README.md
