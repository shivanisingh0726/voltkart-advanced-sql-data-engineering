WITH cte_1 AS (
    SELECT
        customer_id,
        SUM(order_total) AS total_order_per_customer
    FROM fact_orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
),
cte_2 AS (
    SELECT
        total_order_per_customer,
        NTILE(4) OVER (
            ORDER BY total_order_per_customer
        ) AS spend_quartile
    FROM cte_1
)
SELECT
    spend_quartile,
    AVG(total_order_per_customer) AS avg_lifetime_spend,
    COUNT(total_order_per_customer) AS customer_count
FROM cte_2
GROUP BY spend_quartile;
