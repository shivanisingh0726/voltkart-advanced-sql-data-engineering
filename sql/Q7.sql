WITH cte AS (
    SELECT
        employee_id,
        employee_name,
        manager_id,
        role,
        employee_id AS root_employee_id
    FROM dim_employee

    UNION ALL

    SELECT
        d.employee_id,
        d.employee_name,
        d.manager_id,
        d.role,
        c.root_employee_id
    FROM dim_employee d
    JOIN cte c
        ON d.manager_id = c.employee_id
),
team_revenue AS (
    SELECT
        c.root_employee_id,
        SUM(o.order_total) AS team_total_revenue
    FROM cte c
    JOIN fact_orders o
        ON c.employee_id = o.sales_rep_id
    WHERE o.order_status = 'Completed'
    GROUP BY c.root_employee_id
)
SELECT
    e.employee_id,
    e.employee_name,
    e.role,
    COALESCE(tr.team_total_revenue, 0) AS team_total_revenue
FROM dim_employee e
LEFT JOIN team_revenue tr
    ON e.employee_id = tr.root_employee_id
ORDER BY team_total_revenue DESC;
