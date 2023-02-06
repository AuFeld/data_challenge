WITH sessions AS (
    select * from {{ ref('mart_sessions') }}
),
session_summary AS (
  SELECT 
    session_id, 
    cookie_id, 
    COUNT(CASE WHEN event_name = 'page' THEN 1 END) AS page_events
  FROM sessions
  GROUP BY session_id, cookie_id
)
SELECT 
  COUNT(*) as num_sessions
FROM session_summary
WHERE page_events <= 1
