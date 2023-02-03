WITH orders AS (
    SELECT * FROM {{ source('boll', 'orders') }}
)
SELECT
    line_items.line_id,
    line_items.product_id,
    line_items.variant_id,
    line_items.price,
    line_items.quantity,
    line_items.line_total_discount
FROM
    orders