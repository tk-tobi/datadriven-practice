SELECT
  DATE_TRUNC('day', session_start) AS day,
  COUNT(DISTINCT user_id) AS dau
FROM user_sessions
GROUP BY DATE_TRUNC('day', session_start)
ORDER BY 1
