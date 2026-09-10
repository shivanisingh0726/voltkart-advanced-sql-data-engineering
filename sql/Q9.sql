MERGE INTO dim_product AS target
USING cdc_product_changes AS source
ON target.product_id = source.product_id
WHEN MATCHED AND source.operation = 'U' THEN
    UPDATE SET
        target.product_name = source.product_name,
        target.category_id = source.category_id,
        target.unit_price = source.unit_price,
        target.unit_cost = source.unit_cost,
        target.launch_date = source.launch_date
WHEN MATCHED AND source.operation = 'D' THEN
    DELETE
WHEN NOT MATCHED BY TARGET
     AND source.operation = 'I' THEN
    INSERT (
        product_id,
        product_name,
        category_id,
        unit_price,
        unit_cost,
        launch_date
    )
    VALUES (
        source.product_id,
        source.product_name,
        source.category_id,
        source.unit_price,
        source.unit_cost,
        source.launch_date
    );
