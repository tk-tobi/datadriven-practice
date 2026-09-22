WITH yr_sales AS (
  SELECT transaction_id, total_amount, product_id
  FROM transactions
  WHERE EXTRACT(YEAR FROM transaction_date) = 2026
)
SELECT
  p.category,
  COUNT(DISTINCT t.transaction_id) AS unique_transaction,
  SUM(t.total_amount) AS total_revenue
FROM yr_sales AS t
JOIN products AS p
  ON t.product_id = p.product_id
GROUP BY p.category
HAVING COUNT(t.transaction_id) > 1
ORDER BY total_revenue DESC;
