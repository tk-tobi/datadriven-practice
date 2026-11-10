SELECT
  region,
  status,
  COUNT(*) AS order_count
FROM orders
WHERE region IS NOT NULL 
  AND status IS NOT NULL
GROUP BY region, status
HAVING COUNT(*) > 3
ORDER BY 3 DESC;
