SELECT
  p.product_name,
  SUM(t.total_amount) AS total_revenue
FROM transactions AS t
INNER JOIN products AS p
  ON t.product_id = p.product_id
WHERE p.product_name IS NOT NULL
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 5
-- QUALIFY COUNT(*) OVER (PARTITION OVER p.product_name) = 1;
