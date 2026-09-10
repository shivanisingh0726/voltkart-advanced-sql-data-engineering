SELECT TOP 20
    o.order_id,
    o.order_date,
    c.customer_name,
    e.employee_name AS sales_rep_name,
    o.order_total
FROM dbo.fact_orders o
INNER JOIN dbo.dim_customer c
    ON o.customer_id = c.customer_id
INNER JOIN dbo.dim_employee e
    ON o.sales_rep_id = e.employee_id
WHERE o.order_status = 'Completed'
ORDER BY o.order_total DESC;
