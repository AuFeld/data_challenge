{{
  config(
    materialized = 'view'
  )
}}
WITH src_web_events AS (
    SELECT * FROM {{ ref('src_web_events') }}
)
SELECT
    web_event_id,
    loaded_at,
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
    src_web_events