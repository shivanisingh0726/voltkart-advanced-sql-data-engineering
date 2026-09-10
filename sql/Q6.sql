WITH cte AS (
    SELECT
        category_id,
        category_name,
        0 AS depth_level,
        CAST(category_name AS NVARCHAR(MAX)) AS category_path
    FROM dim_category
    WHERE category_name = 'Computers'

    UNION ALL

    SELECT
        d.category_id,
        d.category_name,
        c.depth_level + 1,
        CAST(c.category_path + N' > ' + d.category_name AS NVARCHAR(MAX))
    FROM dim_category d
    JOIN cte c
        ON d.parent_category_id = c.category_id
)
SELECT *
FROM cte;
