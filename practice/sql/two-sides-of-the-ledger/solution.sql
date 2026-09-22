-- SELECT * FROM cloud_costs
-- SELECT * FROM cost_allocs

WITH stacked_cloud_charges AS (
  SELECT
    region,
    amount * -1 AS amount,
    bill_date AS event_date
  FROM cloud_costs
  
  UNION ALL
  
  SELECT
    region,
    amount,
    period AS event_date
  FROM cost_allocs
)

SELECT
  region,
  event_date,
  amount AS amt,
  SUM(amount) OVER (
    PARTITION BY region ORDER BY event_date
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_balance
FROM stacked_cloud_charges
ORDER BY region, event_date
