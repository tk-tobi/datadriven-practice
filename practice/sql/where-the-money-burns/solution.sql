SELECT
  svc_name
FROM cloud_costs
GROUP BY svc_name
HAVING AVG(amount) > (SELECT AVG(amount) FROM cloud_costs)
ORDER BY svc_name;

/* Checks */
-- SELECT * FROM cloud_costs LIMIT 5;
