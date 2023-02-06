WITH sessions AS (
    select * from {{ ref('mart_sessions') }}
),
session_stats AS (
  SELECT 
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN event_name = 'email_sign_up' THEN session_id END) AS signup_sessions
  FROM sessions
)
SELECT 
  signup_sessions / total_sessions AS signup_rate
FROM session_stats
