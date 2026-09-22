/*
CTEs ->
First: collapse to the correct grain
Second: Calculate Rolling AV
*/
WITH monthly_transactions AS (
  SELECT
    transaction_id,
    SUM(total_amount) AS monthly_total,
    STRFTIME('%Y-%m', transaction_date) AS ym
  FROM transactions
  GROUP BY 3
)

SELECT
  ym,
  AVG(monthly_total) OVER (
    ORDER BY ym
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg
FROM monthly_transactions
-- SELECT COUNT(*) FROM transactions;
