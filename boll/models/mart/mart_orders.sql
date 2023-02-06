WITH stg_orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
)
SELECT
    order_id,
    order_loaded_at,
    order_created_at,
    order_updated_at,
    order_subtotal,
    order_total,
    line_items_line_id,
    line_items_product_id,
    line_items_variant_id,
    line_items_price,
    line_items_quantity,
    line_items_line_total_discount
FROM
    stg_orders