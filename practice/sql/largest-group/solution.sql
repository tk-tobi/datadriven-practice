-- WITH department_emp_count AS (
--   SELECT
--     department,
--     COUNT(*) AS emp_count
--   FROM employees
--   GROUP BY department
-- )
  
-- SELECT
--   department,
--   emp_count
-- FROM (
--   SELECT
--     department,
--     emp_count,
--     RANK() OVER (ORDER BY emp_count DESC) AS dept_rnk
--   FROM department_emp_count
-- ) sub_table
-- WHERE dept_rnk = 1

-- SELECT 
--   department, 
--   COUNT(*) AS emp_count,
--   RANK() OVER (ORDER BY COUNT(*) DESC)
-- FROM employees 
-- GROUP BY department
-- QUALIFY RANK() OVER (ORDER BY COUNT(*) DESC) = 1;

-- SELECT
--   department,
--   emp_count
-- FROM (
--   SELECT
--     department,
--     COUNT(*) AS emp_count,
--     RANK() OVER (ORDER BY COUNT(*) DESC) AS rnk
--   FROM employees
--   GROUP BY department
-- ) sub_table
-- WHERE rnk = 1

SELECT 
  department, 
  COUNT(*) AS emp_count
FROM employees
GROUP BY department
HAVING COUNT(*) = (
  SELECT MAX(dept_count)
  FROM (
    SELECT COUNT(*) AS dept_count
    FROM employees
    GROUP BY department
  ) max_subquery
);
