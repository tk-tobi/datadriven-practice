SELECT
  p.category,
  AVG(t.total_amount) AS avg_amount
FROM products AS p
JOIN transactions AS t
  ON p.product_id = t.product_id
GROUP BY p.category
ORDER BY 2 DESC
LIMIT 3
