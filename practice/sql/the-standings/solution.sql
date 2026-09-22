SELECT
  p.category,
  SUM(t.total_amount) AS total_revenue,
  SUM(t.quantity) AS total_units,
  DENSE_RANK() OVER (ORDER BY SUM(t.total_amount) DESC) AS position
FROM transactions AS t
JOIN products AS p
  ON t.product_id = p.product_id
GROUP BY p.category
ORDER BY SUM(total_amount) DESC
