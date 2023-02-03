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
    loaded_at,
    created_at,
    updated_at,
    subtotal,
    total,
    line_items_line_id,
    line_items_product_id,
    line_items_variant_id,
    line_items_price,
    line_items_quantity,
    COALESCE(
      line_items_line_total_discount,
      0
    ) as line_items_line_total_discount
FROM
    src_orders