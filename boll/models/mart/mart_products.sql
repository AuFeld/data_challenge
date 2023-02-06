WITH stg_products AS (
    SELECT * FROM {{ ref('stg_products') }}
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
    variant_option2
FROM
    stg_products