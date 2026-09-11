WITH lifetime_value AS (
    SELECT
        customer_id,
        SUM(order_total) AS lifetime_value
    FROM fact_orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
)
SELECT
    o.customer_id,
    COUNT(*) AS orders_2024,
    lv.lifetime_value
FROM fact_orders o
LEFT JOIN lifetime_value lv
    ON o.customer_id = lv.customer_id
WHERE o.order_date >= '2024-01-01'
  AND o.order_date < '2025-01-01'
GROUP BY
    o.customer_id,
    lv.lifetime_value;
