WITH products AS (
    SELECT * FROM {{ source('boll', 'products') }}
)
SELECT
    _id AS product_id,
    _load_at AS loaded_at,
    category,
    created_at,
    updated_at,
    title,
    variants.variant_id,
    variants.sku,
    variants.title,
    variants.created_at,
    variants.updated_at,
    variants.option1,
    variants.option2
FROM 
    products CROSS JOIN UNNEST(variants) AS variants