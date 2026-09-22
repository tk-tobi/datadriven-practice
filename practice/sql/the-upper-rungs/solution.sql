-- SELECT * FROM employee_metrics

-- SELECT
--   DISTINCT metric_value AS benchmark_value
-- FROM (
--   SELECT
--     metric_value,
--     RANK() OVER (ORDER BY metric_value DESC) AS rnk
--   FROM employee_metrics
--   GROUP BY metric_value
-- )sub_table
-- WHERE rnk < 6;
  


SELECT
  DISTINCT metric_value AS benchmark_value
FROM employee_metrics
ORDER BY metric_value DESC
LIMIT 5
