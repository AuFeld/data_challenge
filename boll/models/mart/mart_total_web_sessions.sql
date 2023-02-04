{{ config(
  materialized = 'table',
) }}

WITH web_events AS (
  SELECT cookie_id, timestamp,
         ROW_NUMBER() OVER (PARTITION BY cookie_id ORDER BY timestamp) AS event_number
  FROM mart_web_events
),
sessions AS (
  SELECT cookie_id, MIN(timestamp) AS start_time, MAX(timestamp) AS end_time
  FROM (
    SELECT cookie_id, timestamp,
           SUM(CASE WHEN timestamp - LAG(timestamp) OVER (PARTITION BY cookie_id ORDER BY timestamp) <= INTERVAL 30 MINUTE THEN 0 ELSE 1 END)
           OVER (PARTITION BY cookie_id ORDER BY timestamp) AS session_number
    FROM web_events
  )
  GROUP BY cookie_id, session_number
)
SELECT COUNT(DISTINCT cookie_id) AS web_sessions, 
        web_events.web_event_id, 
        web_events.loaded_at, 
        web_events.cookie_id,
        web_events.customer_id,
        web_events.event_name,
        web_events.event_url,
        web_events.event_properties,
        web_events.timestamp,
        web_events.utm_campaign,
        web_events.utm_source,
        web_events.utm_medium
FROM sessions
JOIN mart_web_events
ON sessions.cookie_id = mart_web_events.cookie_id
