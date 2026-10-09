SELECT
  DISTINCT amount
FROM cloud_costs
WHERE amount IS NOT NULL
ORDER BY amount
LIMIT 3;
