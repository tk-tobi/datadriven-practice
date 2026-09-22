/*
metric_*
SUM() OVER (PARTITION BY department ORDER BY yr, qrt)
*/
SELECT
  metric_id,
  department,
  metric_name,
  metric_value,
  fiscal_quarter,
  fiscal_year,
  SUM(metric_value) OVER (PARTITION BY department ORDER BY fiscal_year, fiscal_quarter) AS running_total
FROM employee_metrics
