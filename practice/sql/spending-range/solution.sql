/*
COUNT(transaction) > 1
GROUP BY user_id
ORDER BY MAX - MIN

shape:
username, MIN(total_amount), MAX(total_amount), MAX - MIN
*/

SELECT
  u.username,
  MIN(t.total_amount) AS low,
  MAX(t.total_amount) AS high,
  ROUND(MAX(t.total_amount) - MIN(t.total_amount), 3) AS diff
FROM users AS u
JOIN transactions AS t
  ON u.user_id = t.user_id
GROUP BY u.username
HAVING COUNT(*) > 1
ORDER BY 4 DESC
