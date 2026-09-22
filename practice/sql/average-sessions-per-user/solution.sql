SELECT
  (COUNT(session_id) * 1.0) / COUNT(DISTINCT user_id) AS avg_session_per_user
FROM user_sessions
  

/* Checks */
-- SELECT * FROM user_sessions LIMIT 5;
