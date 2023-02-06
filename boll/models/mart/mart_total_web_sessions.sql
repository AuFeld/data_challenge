WITH sessions AS (
  SELECT * FROM {{ ref('mart_sessions') }}
)
SELECT 
  COUNT(DISTINCT session_id) as num_sessions
FROM sessions
