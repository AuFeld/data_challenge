{{
  config(
    materialized = 'view'
  )
}}
WITH src_orders AS (
    SELECT * FROM {{ ref('src_orders') }}
)
SELECT
    order_id,
    SAFE_CAST(order_loaded_at AS TIMESTAMP) as order_loaded_at,
    SAFE_CAST(order_created_at AS TIMESTAMP) as order_created_at,
    SAFE_CAST(order_updated_at AS TIMESTAMP) as order_updated_at,
    order_subtotal,
    order_total,
    line_items_line_id,
    line_items_product_id,
    line_items_variant_id,
    line_items_price,
    line_items_quantity,
    line_items_line_total_discount
FROM
    src_orders