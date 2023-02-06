{{
  config(
    materialized = 'view'
  )
}}
WITH src_web_events AS (
    SELECT * FROM {{ ref('src_web_events') }}
)
SELECT
    SAFE_CAST(web_event_id as STRING) as web_event_id,
    SAFE_CAST(loaded_at as timestamp) as loaded_at,
    SAFE_CAST(cookie_id as string) as cookie_id,
    customer_id,
    SAFE_CAST(event_name as string) as event_name,
    SAFE_CAST(event_url as string) as event_url,
    event_properties,
    SAFE_CAST(timestamp as timestamp) as timestamp,
    SAFE_CAST(utm_campaign as STRING) as utm_campaign,
    SAFE_CAST(utm_source as STRING) as utm_source,
    SAFE_CAST(utm_medium as STRING) as utm_medium
FROM
    src_web_events