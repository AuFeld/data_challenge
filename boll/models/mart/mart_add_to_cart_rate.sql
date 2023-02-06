with sessions as (
    select * from {{ ref('mart_sessions') }}
), 
session_stats AS (
  SELECT 
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_name = 'product_added' THEN session_id END) AS product_added_sessions
  FROM sessions
)
SELECT 
  product_added_sessions / total_sessions AS add_to_cart_rate
FROM session_stats
