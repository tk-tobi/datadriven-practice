WITH department_metrics AS (
  SELECT
    department,
    IFNULL(SUM(metric_value), 0) AS total_metric_value
  FROM employee_metrics
  GROUP BY department
)

SELECT
  e.emp_name,
  em.total_metric_value
FROM employees AS e
LEFT JOIN department_metrics AS em
  ON e.department = em.department
