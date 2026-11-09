SELECT
  DISTINCT user_id
FROM user_sessions
WHERE session_start BETWEEN '2025-06-13' AND '2025-12-19'

-- SELECT * FROM user_sessions LIMIT 5;
