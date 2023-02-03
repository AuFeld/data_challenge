WITH orders AS (
    SELECT * FROM {{ source('boll', 'orders') }}
)
SELECT
    _id as order_id,
    _loaded_at as loaded_at,
    created_at,
    updated_at,
    subtotal,
    total, 
    line_items.line_id,
    line_items.product_id,
    line_items.variant_id,
    line_items.price,
    line_items.quantity,
    line_items.line_total_discount

FROM orders CROSS JOIN UNNEST(line_items) AS line_items