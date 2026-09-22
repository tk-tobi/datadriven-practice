-- SELECT * FROM transactions

WITH first_user_transaction AS (
  SELECT
    user_id,
    MIN(transaction_date) AS first_transaction,
    DATE_ADD(MIN(transaction_date), 1) AS first_day
  FROM transactions
  GROUP BY user_id
),
products_purchased AS (
  SELECT
    t.user_id,
    t.product_id
  FROM transactions AS t
  JOIN first_user_transaction AS f
    ON t.user_id = f.user_id
  WHERE t.transaction_date = f.first_transaction
)

SELECT 
  COUNT(DISTINCT t.user_id) AS user_count 
FROM transactions AS t
JOIN first_user_transaction AS f
  ON t.user_id = f.user_id
WHERE t.transaction_date > f.first_day
AND product_id NOT IN (SELECT product_id FROM products_purchased AS p WHERE p.user_id = t.user_id)
