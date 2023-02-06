WITH 
  mart_products AS (
    SELECT * FROM {{ ref('mart_products') }}
  ),
  mart_orders AS (
    SELECT * FROM {{ ref('mart_orders') }}
  )
SELECT 
  mart_products.*,
  mart_orders.*
FROM 
  mart_products
JOIN 
  mart_orders
ON 
  mart_products.variant_id = mart_orders.line_items_variant_id
