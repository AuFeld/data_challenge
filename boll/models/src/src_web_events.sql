WITH web_events AS (
    SELECT * FROM {{ source('boll', 'web_events') }}
)
SELECT
    _id AS web_event_id,
    _loaded_at as loaded_at,
    cookie_id,
    customer_id,
    event_name,
    event_url,
    event_properties,
    timestamp,
    utm_campaign,
    utm_source,
    utm_medium
FROM 
    web_events