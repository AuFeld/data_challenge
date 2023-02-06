WITH sessions AS (
    select * from {{ ref('mart_sessions') }}
),
session_stats AS (
  SELECT 
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_name = 'order_completed' THEN session_id END) AS conversion_sessions
  FROM sessions
)
SELECT 
  conversion_sessions / total_sessions AS conversion_rate
FROM session_stats
