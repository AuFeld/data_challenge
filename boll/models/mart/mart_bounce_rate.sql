WITH sessions AS (
    select * from {{ ref('mart_sessions') }}
),
sessions_summary AS (
  SELECT 
    session_id, 
    COUNT(CASE WHEN event_name = 'product_viewed' THEN 1 END) AS viewed_events
  FROM sessions
  GROUP BY session_id
)
SELECT 
  SUM(CASE WHEN viewed_events > 0 THEN 1 ELSE 0 END) / COUNT(*) AS bounce_rate
FROM sessions_summary