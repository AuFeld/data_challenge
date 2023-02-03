WITH products AS (
    SELECT * FROM {{ source('boll', 'products') }}
)
SELECT
    variants.variant_id,
    variants.sku as variant_sku,
    variants.title as variant_title,
    variants.created_at as variant_created_at,
    variants.updated_at as variant_updated_at,
    variants.option1 as variant_option1,
    variants.option2 as variant_option2
FROM 
    products