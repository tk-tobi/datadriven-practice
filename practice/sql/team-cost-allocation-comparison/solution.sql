SELECT
  team_name,
  svc_name,
  amount,
  MAX(amount) OVER (PARTITION BY team_name) AS manager_amount,
  AVG(amount) OVER (PARTITION BY team_name) AS dept_avg
FROM cost_allocs
-- WHERE team_name = 'DATA-ENG'
