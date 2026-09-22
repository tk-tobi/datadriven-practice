SELECT 
  SUBSTRING(session_start, 1, 7) AS month,
  COUNT(DISTINCT user_id) AS unique_active_users,
  ROUND(AVG(session_duration_sec), 3) AS avg_monthly_session_duration_sec
FROM user_sessions
WHERE session_start BETWEEN '2026-07-01' AND '2026-12-31'
GROUP BY 1
HAVING COUNT(*) > 3
ORDER BY month;
