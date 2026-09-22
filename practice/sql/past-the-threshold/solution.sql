SELECT
  u.user_id,
  COUNT(us.user_id) AS session_count
FROM users u
JOIN user_sessions us
  ON u.user_id = us.user_id
-- WHERE u.account_status = 'active'
GROUP BY u.user_id
HAVING COUNT(us.user_id) > 3
