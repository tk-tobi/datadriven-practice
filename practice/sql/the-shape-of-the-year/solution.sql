-- SELECT * FROM transactions LIMIT 10
SELECT
  SUBSTRING(transaction_date, 1, 7) AS month,
  SUM(total_amount) AS total_revenue,
  COUNT(*) AS num_transactions,
  AVG(total_amount) AS avg_transaction_value
FROM transactions
GROUP BY SUBSTRING(transaction_date, 1, 7)
ORDER BY 1
