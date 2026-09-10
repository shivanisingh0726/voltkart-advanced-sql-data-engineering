WITH ranked_category_name AS (
    SELECT
        category_name,
        product_name,
        SUM(line_amount) AS total_revenue,
        RANK() OVER (
            PARTITION BY category_name
            ORDER BY SUM(line_amount) DESC
        ) AS revenue_rank
    FROM dim_category c
    JOIN dim_product p
        ON c.category_id = p.category_id
    JOIN fact_order_items oi
        ON oi.product_id = p.product_id
    JOIN fact_orders o
        ON o.order_id = oi.order_id
    WHERE order_status = 'Completed'
    GROUP BY category_name, product_name
)
SELECT *
FROM ranked_category_name
WHERE revenue_rank <= 3;
