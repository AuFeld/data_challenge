SELECT COUNT(DISTINCT session_group)
FROM (
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
    utm_medium, 
    ROW_NUMBER() OVER (PARTITION BY cookie_id ORDER BY loaded_at) - 
    ROW_NUMBER() OVER (PARTITION BY cookie_id, 
                       FLOOR((timestamp - MIN(timestamp) OVER (PARTITION BY cookie_id)) / 1800) 
                       ORDER BY loaded_at) AS session_group 
  FROM {{ ref('mart_web_events')}}
)
