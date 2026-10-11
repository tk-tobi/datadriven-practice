SELECT
  u.user_id,
  COUNT(DISTINCT p.category) AS category_count
FROM users u
LEFT JOIN transactions t
  ON u.user_id = t.user_id
LEFT JOIN products p
  ON t.product_id = p.product_id
WHERE t.total_amount < 500
GROUP BY u.user_id
HAVING COUNT(DISTINCT p.category) > 1
ORDER BY 2 DESC;
