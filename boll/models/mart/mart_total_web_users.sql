WITH sessions AS (
    select * from {{ ref('mart_sessions') }}
),
user_mapping AS (
  SELECT 
    session_id, 
    COALESCE(MIN(customer_id), MIN(cookie_id)) AS user_id
  FROM sessions
  WHERE customer_id IS NOT NULL OR cookie_id IS NOT NULL
  GROUP BY session_id
)
SELECT 
  COUNT(DISTINCT user_id) AS num_users
FROM user_mapping
