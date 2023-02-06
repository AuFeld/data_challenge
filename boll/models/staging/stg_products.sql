WITH src_products AS (
    SELECT * FROM {{ ref('src_products') }}
)
SELECT
    product_id,
    SAFE_CAST(product_loaded_at AS TIMESTAMP) as product_loaded_at,
    SAFE_CAST(product_category AS STRING) as product_category,
    SAFE_CAST(product_created_at AS TIMESTAMP) as product_created_at,
    SAFE_CAST(prodcut_updated_at AS TIMESTAMP) as prodcut_updated_at,
    SAFE_CAST(product_title AS STRING) as product_title,
    variant_id, 
    SAFE_CAST(variant_sku AS STRING) as variant_sku, 
    SAFE_CAST(variant_title AS STRING) as variant_title, 
    SAFE_CAST(variant_created_at as TIMESTAMP) as variant_created_at, 
    SAFE_CAST(variant_updated_at AS TIMESTAMP) as variant_updated_at, 
    SAFE_CAST(
        REPLACE(variant_option1,
            '$',
            ''
        ) as FLOAT64
    ) as variant_option1,
    SAFE_CAST(
        REPLACE(
            variant_option2,
            '$',
            ''
        ) as FLOAT64
    ) as variant_option2
FROM
    src_products