SELECT
  u.user_id,
  u.username
FROM users AS u
LEFT JOIN user_sessions AS s
  ON u.user_id = s.user_id
WHERE s.user_id IS NULL
