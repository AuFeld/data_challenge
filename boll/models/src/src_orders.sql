WITH orders AS (
    SELECT * FROM {{ source('boll', 'orders') }}
)
SELECT
    _id as order_id,
    _loaded_at as order_loaded_at,
    created_at as order_created_at,
    updated_at as order_updated_at,
    subtotal as order_subtotal,
    total as order_total,
    line_items.line_id as line_items_line_id,
    line_items.product_id as line_items_product_id,
    line_items.variant_id as line_items_variant_id,
    line_items.price as line_items_price,
    line_items.quantity as line_items_quantity,
    line_items.line_total_discount as line_items_line_total_discount,
FROM 
    orders CROSS JOIN UNNEST(line_items) AS line_items