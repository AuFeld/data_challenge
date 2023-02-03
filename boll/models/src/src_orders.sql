WITH orders AS (
    SELECT * FROM {{ source('boll', 'orders') }}
)
SELECT
    _id as order_id,
    _loaded_at as loaded_at,
    created_at,
    updated_at,
    subtotal,
    total
FROM 
    orders CROSS JOIN UNNEST(line_items) AS line_items