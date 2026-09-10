MERGE INTO fact_orders AS orders
USING stg_orders_incr AS stg_orders
ON orders.order_id = stg_orders.order_id
WHEN MATCHED THEN
    UPDATE SET
        orders.order_status = stg_orders.order_status,
        orders.order_total = stg_orders.order_total
WHEN NOT MATCHED THEN
    INSERT (
        order_id,
        order_date,
        customer_id,
        sales_rep_id,
        order_status,
        order_total
    )
    VALUES (
        stg_orders.order_id,
        stg_orders.order_date,
        stg_orders.customer_id,
        stg_orders.sales_rep_id,
        stg_orders.order_status,
        stg_orders.order_total
    );
