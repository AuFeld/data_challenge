{{
  config(
    materialized = 'view'
  )
}}
WITH src_products AS (
    SELECT * FROM {{ ref('src_products') }}
)
SELECT
    product_id,
    product_loaded_at,
    product_category,
    product_created_at,
    prodcut_updated_at,
    product_title,
    variant_id,
    variant_sku,
    variant_title,
    variant_created_at,
    variant_updated_at,
    variant_option1,
   CAST(
        IFNULL(
            NULL,
            0
        ) as integer
    ) as variant_option2
FROM
    src_products