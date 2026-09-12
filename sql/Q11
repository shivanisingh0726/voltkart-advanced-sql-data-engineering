WITH completed_months AS (
    SELECT DISTINCT
        customer_id,
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS order_month
    FROM fact_orders
    WHERE order_status = 'Completed'
),
numbered_months AS (
    SELECT
        customer_id,
        order_month,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY order_month
        ) AS month_number
    FROM completed_months
),
streak_groups AS (
    SELECT
        customer_id,
        order_month,
        DATEADD(MONTH, -month_number, order_month) AS streak_group
    FROM numbered_months
),
streak_lengths AS (
    SELECT
        customer_id,
        streak_group,
        COUNT(*) AS streak_months
    FROM streak_groups
    GROUP BY
        customer_id,
        streak_group
)
SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(MAX(sl.streak_months), 0) AS longest_streak_months
FROM dim_customer c
LEFT JOIN streak_lengths sl
    ON c.customer_id = sl.customer_id
GROUP BY
    c.customer_id,
    c.customer_name;
