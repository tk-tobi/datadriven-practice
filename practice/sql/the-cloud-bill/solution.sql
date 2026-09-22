-- SELECT * FROM cloud_costs LIMIT 5;
SELECT
  SUBSTRING(bill_date, 1, 7) AS month,
  IFNULL(ROUND(SUM(amount) FILTER (WHERE LOWER(provider) = 'aws'), 3), 0) AS aws_total,
  IFNULL(ROUND(SUM(amount) FILTER (WHERE LOWER(provider) = 'gcp'), 3), 0) AS gcp_total,
  IFNULL(ROUND(SUM(amount) FILTER (WHERE LOWER(provider) = 'azure'), 3), 0) AS azure_total
FROM cloud_costs
GROUP BY 1
ORDER BY 1;
