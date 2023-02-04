{{ config(
  materialized = 'table',
) }}
WITH web_events AS (
  SELECT cookie_id, customer_id, timestamp,
         ROW_NUMBER() OVER (PARTITION BY cookie_id ORDER BY timestamp) AS event_number
  FROM mart_web_events
),
sessions AS (
  SELECT cookie_id, MIN(timestamp) AS start_time, MAX(timestamp) AS end_time,
         FIRST_VALUE(customer_id) OVER (PARTITION BY cookie_id ORDER BY timestamp) AS user_id
  FROM (
    SELECT cookie_id, customer_id, timestamp,
           SUM(CASE WHEN timestamp - LAG(timestamp) OVER (PARTITION BY cookie_id ORDER BY timestamp) <= INTERVAL 30 MINUTE THEN 0 ELSE 1 END)
           OVER (PARTITION BY cookie_id ORDER BY timestamp) AS session_number
    FROM web_events
  )
  GROUP BY cookie_id, session_number
)
SELECT COUNT(DISTINCT COALESCE(user_id, cookie_id)) AS distinct_users
FROM sessions