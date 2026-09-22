SELECT
  p.category AS category,
  SUM(p.price * t.quantity) AS total_revenue
FROM transactions AS t
JOIN products AS p
  ON t.product_id = p.product_id
GROUP BY p.category
ORDER BY 2 DESC
