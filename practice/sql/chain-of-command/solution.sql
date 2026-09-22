WITH RECURSIVE 
chain_of_command AS(
  SELECT
    employee_id,
    emp_name,
    0 AS depth,
    emp_name AS path
  FROM employees
  WHERE manager_id IS NULL
  
  UNION ALL
    
  SELECT
    e.employee_id,
    e.emp_name,
    coc.depth + 1 AS depth,
    coc.path + '/' + e.emp_name AS path
  FROM employees AS e
  JOIN chain_of_command AS coc
    ON e.manager_id = coc.employee_id
)
 
  
SELECT * FROM chain_of_command ORDER BY path, employee_id;
-- -- OPTION (MAXRECURSION 500)



-- WITH RECURSIVE tree AS (
--   SELECT
--     employee_id,
--     emp_name,
--     manager_id,
--     0 AS depth,
--     emp_name AS path
--   FROM employees
--   WHERE manager_id IS NULL
--   UNION ALL
--   SELECT
--     e.employee_id,
--     e.emp_name,
--     e.manager_id,
--     t.depth + 1,
--     t.path || '/' || e.emp_name
--   FROM employees AS e
--   INNER JOIN tree AS t
--     ON e.manager_id = t.employee_id
-- )
-- SELECT
--   employee_id,
--   emp_name,
--   depth,
--   path
-- FROM tree
-- ORDER BY path, employee_id
