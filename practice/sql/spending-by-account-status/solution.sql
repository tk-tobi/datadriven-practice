SELECT
  u.account_status AS account_status,
  COUNT(total_amount) AS transaction_count,
  COUNT(DISTINCT u.user_id) AS user_count,
  SUM(t.total_amount) AS total_revenue
FROM users AS u
LEFT JOIN transactions AS t
  ON u.user_id = t.user_id
GROUP BY u.account_status
HAVING COUNT(*) > 5
ORDER BY total_revenue DESC;


  
