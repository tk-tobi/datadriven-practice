SELECT
  product_id,
  total_sales
FROM (
SELECT
  product_id,
  SUM(total_amount) AS total_sales,
  ROW_NUMBER() OVER (ORDER BY SUM(total_amount) DESC) AS rnk
FROM transactions
WHERE product_id IS NOT NULL
-- AND transaction_date >= DATEADD(day, -30, CURRENT_TIMESTAMP())
-- AND transaction_date >= NOW() - INTERVAL '30 DAYS'
  AND transaction_date >= DATE('now', '-30 days')
GROUP BY product_id) sub_table
WHERE rnk <= 3
ORDER BY total_sales DESC;
-- QUALIFY ROW_NUMBER() OVER (ORDER BY SUM(total_amount) DESC) <= 3


-- SELECT * FROM transactions LIMIT 5;
