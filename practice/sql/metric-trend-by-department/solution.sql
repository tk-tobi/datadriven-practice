/*
AVG(metric_value)
GROUP BY dept, fis_year

shape:
dept, fisc_yr, avg_metric
*/

SELECT
  department,
  fiscal_year,
  AVG(metric_value) AS avg_metric_value
FROM employee_metrics
GROUP BY 1, 2
