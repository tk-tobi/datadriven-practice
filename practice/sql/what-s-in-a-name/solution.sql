SELECT
  SUBSTRING(username, 1, 1) AS initial,
  COUNT(*) AS user_count,
  ROUND((COUNT(*)*1.0 / SUM(COUNT(*)) OVER ())*100, 1) AS pct
FROM users
GROUP BY SUBSTRING(username, 1, 1)
ORDER BY user_count DESC
