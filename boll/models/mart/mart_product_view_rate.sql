WITH sessions AS (
    select * from {{ ref('mart_sessions') }}
),
session_stats AS (
  SELECT 
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_name = 'product_viewed' THEN session_id END) AS product_viewed_sessions
  FROM sessions
)
SELECT 
  product_viewed_sessions / total_sessions AS product_view_rate
FROM session_stats
