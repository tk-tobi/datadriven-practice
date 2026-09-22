SELECT
  COUNT(*)
FROM users
WHERE STRFTIME('%Y', signup_date) = '2026'
