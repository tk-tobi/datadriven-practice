WITH prev_charges AS (
  SELECT
    transaction_id,
    user_id,
    product_id,
    total_amount,
    transaction_date,
    LAG(total_amount) OVER 
      (PARTITION BY user_id, product_id
      ORDER BY transaction_date) AS prev_total_amount,
    LAG(transaction_date) OVER 
      (PARTITION BY user_id, product_id
      ORDER BY transaction_date) AS prev_transaction_date
  FROM transactions
),
flagged_charges AS (
  SELECT * 
  FROM prev_charges 
  WHERE prev_total_amount = total_amount 
    AND transaction_date::DATE - prev_transaction_date::DATE <= 35
)
SELECT
  transaction_id,
  user_id,
  product_id,
  total_amount,
  transaction_date
FROM flagged_charges
ORDER BY 5;
