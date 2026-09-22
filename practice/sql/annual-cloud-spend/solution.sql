SELECT
  EXTRACT(YEAR FROM bill_date) AS year,
  SUM(amount)
FROM cloud_costs
GROUP BY year
ORDER BY year;
