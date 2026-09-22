SELECT
  u.username,
  SUM(t.total_amount),
  ROW_NUMBER() OVER (ORDER BY SUM(t.total_amount) DESC) AS rnk
FROM users AS u
JOIN transactions AS t
  ON u.user_id = t.user_id
GROUP BY u.user_id
ORDER BY rnk
LIMIT 5
