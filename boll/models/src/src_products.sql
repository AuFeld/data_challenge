WITH products AS (
    SELECT * FROM {{ source('boll', 'products') }}
)
SELECT
    _id AS product_id,
    _load_at AS product_loaded_at,
    category AS product_category,
    created_at AS product_created_at,
    updated_at AS prodcut_updated_at,
    title as product_title
FROM 
    products CROSS JOIN UNNEST(variants) AS variants