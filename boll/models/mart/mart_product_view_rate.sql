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
SELECT SUM(CASE WHEN product_viewed THEN 1 ELSE 0 END) / COUNT(DISTINCT cookie_id) AS ratio
FROM (
  SELECT cookie_id, EXISTS (
    SELECT 1
    FROM `mart_web_events`
    WHERE cookie_id = sessions.cookie_id
      AND event_type = 'product_viewed'
      AND timestamp >= sessions.start_time
      AND timestamp <= sessions.end_time
  ) AS product_viewed
  FROM sessions
)
