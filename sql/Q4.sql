WITH monthly_revenue AS (
    SELECT
        DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1) AS order_month,
        SUM(order_total) AS monthly_revenue
    FROM fact_orders
    WHERE order_status = 'Completed'
    GROUP BY DATEFROMPARTS(YEAR(order_date), MONTH(order_date), 1)
),
monthly_data AS (
    SELECT
        order_month,
        monthly_revenue,
        SUM(monthly_revenue) OVER (
            ORDER BY order_month
        ) AS running_total,
        LAG(monthly_revenue) OVER (
            ORDER BY order_month
        ) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    CONVERT(CHAR(7), order_month, 120) AS order_month,
    monthly_revenue,
    running_total,
    (monthly_revenue - previous_month_revenue)
        / previous_month_revenue * 100 AS mom_pct_change
FROM monthly_data;
