-- SELECT
--   department,
--   emp_name,
--   salary
-- FROM (
--   SELECT
--     department,
--     emp_name,
--     salary,
--     DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rnk
--     -- COUNT() OVER (PARTITION BY department) AS head_count
--   FROM employees
-- ) sub_table
-- WHERE salary_rnk = 3 
-- -- AND head_count > 2


SELECT
  department,
  emp_name,
  salary
FROM (
  SELECT
    department,
    emp_name,
    salary,
    DENSE_RANK() OVER (
      PARTITION BY department
      ORDER BY salary DESC
    ) AS rnk
  FROM employees
) AS ranked
WHERE rnk = 3
