/*
SELECT
  DISTINCT amount
FROM (
  SELECT
    amount,
    DENSE_RANK() OVER (ORDER BY amount DESC) AS rnking
  FROM cloud_costs ) sub_table
WHERE rnking = 3;
*/

SELECT
  amount
FROM cloud_costs
GROUP BY amount
ORDER BY amount DESC
LIMIT 1 OFFSET 2;
