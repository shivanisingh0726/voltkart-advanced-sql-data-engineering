# Q10 — Query Optimization

## Optimization Approach

The original query used a correlated subquery to calculate lifetime value and applied `YEAR(order_date) = 2024` as a filter.

The query was optimized by:
- Calculating lifetime value using a CTE.
- Replacing the `YEAR()` filter with a SARGable date range.
- Adding nonclustered indexes to improve data access.

## Performance Comparison

| Metric | Before | After |
|---|---:|---:|
| Logical Reads | 653 | 195 |
| CPU Time | 78 ms | 31 ms |
| Rows Returned | 1,965 | 1,965 |

The optimized query reduced logical reads and CPU time while returning the same number of rows.

## Execution Plan

The execution plans are included below:

- `before_execution_plan.png`
- `after_execution_plan.png`

The statistics IO screenshots are also included:

- `before_statistics_io.png`
- `after_statistics_io.png`
