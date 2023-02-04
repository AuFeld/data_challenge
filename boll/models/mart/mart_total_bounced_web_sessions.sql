{{ config(
  materialized = 'table',
) }}

WITH web_events AS (
  SELECT cookie_id, event_type, timestamp,
         ROW_NUMBER() OVER (PARTITION BY cookie_id ORDER BY timestamp) AS event_number
  FROM mart_web_events
),
sessions AS (
  SELECT cookie_id, MIN(timestamp) AS start_time, MAX(timestamp) AS end_time
  FROM (
    SELECT cookie_id, event_type, timestamp,
           SUM(CASE WHEN timestamp - LAG(timestamp) OVER (PARTITION BY cookie_id ORDER BY timestamp) <= INTERVAL 30 MINUTE THEN 0 ELSE 1 END)
           OVER (PARTITION BY cookie_id ORDER BY timestamp) AS session_number
    FROM web_events
  )
  GROUP BY cookie_id, session_number
)
SELECT COUNT(DISTINCT cookie_id) AS web_sessions
FROM sessions
WHERE (
  SELECT COUNT(*)
  FROM mart_web_events
  WHERE cookie_id = sessions.cookie_id
    AND event_type = 'page'
    AND timestamp >= sessions.start_time
    AND timestamp <= sessions.end_time
) <= 1
