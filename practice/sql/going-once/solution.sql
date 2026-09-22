/*
COUNT(*) AS reference_count,
MAX(amount) AS highest_amount

FROM products
LEFT JOIN transactions
WHERE in_stock = 1

shape:
product_id, product_name, bid_count, highest_bid, winner
*/

SELECT
  product_id,
  product_name,
  bid_count,
  total_amount AS higest_bid,
  user_id AS winner
FROM (
SELECT
  p.product_id,
  p.product_name,
  t.user_id,
  COUNT(t.transaction_id) OVER(PARTITION BY p.product_id) AS bid_count,
  t.total_amount,
  ROW_NUMBER() OVER (PARTITION BY p.product_id ORDER BY t.total_amount DESC, transaction_id) AS rnk
FROM products AS p
LEFT JOIN transactions AS t
  ON p.product_id = t.product_id
WHERE p.in_stock = 1
) sub_table
WHERE rnk = 1
