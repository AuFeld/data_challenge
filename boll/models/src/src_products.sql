WITH products AS (
    SELECT * FROM {{ source('boll', 'products') }}
)
SELECT
    _id AS product_id,
    _loaded_at AS product_loaded_at,
    category AS product_category,
    products.created_at AS product_created_at,
    products.updated_at AS prodcut_updated_at,
    products.title as product_title,
    variants.variant_id as variant_id, 
    variants.sku as variant_sku, 
    variants.title as variant_title, 
    variants.created_at as variant_created_at,
    variants.updated_at as variant_updated_at, 
    variants.option1 as variant_option1,
    variants.option2 as variant_option2
FROM 
    products CROSS JOIN UNNEST(variants) AS variants