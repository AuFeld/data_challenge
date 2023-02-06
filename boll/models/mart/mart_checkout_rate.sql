WITH sessions AS (
    select * from {{ ref('mart_sessions') }}
), 
session_stats AS (
  SELECT 
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_name = 'checkout_step_viewed' THEN session_id END) AS checkout_sessions
  FROM sessions
)
SELECT 
  checkout_sessions / total_sessions AS checkout_rate
FROM session_stats
