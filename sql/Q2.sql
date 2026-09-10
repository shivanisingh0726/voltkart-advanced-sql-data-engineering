SELECT
    c.customer_id,
    c.customer_name,
    c.signup_date
FROM dim_customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM fact_orders o
    WHERE c.customer_id = o.customer_id
);
