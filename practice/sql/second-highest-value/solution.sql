SELECT
  DISTINCT metric_value AS metric_value
FROM employee_metrics
ORDER BY metric_value DESC
LIMIT 1
OFFSET 1;
