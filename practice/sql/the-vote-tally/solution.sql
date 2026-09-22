/*
product 1001

ORDER BY transaction_date ASC
*/

SELECT
  t.transaction_date,
  t.total_amount AS net_revenue
FROM transactions AS t
WHERE t.product_id = 1001
ORDER BY t.transaction_date
