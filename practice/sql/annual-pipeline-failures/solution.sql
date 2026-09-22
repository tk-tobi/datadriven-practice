SELECT 
  EXTRACT(YEAR FROM TO_DATE(start_at)) AS run_year,
  COUNT(*) AS failed_runs
FROM data_pipes
WHERE LOWER(pipe_name) = 'etl_users'
  AND LOWER(status) = 'failed'
  AND start_at IS NOT NULL
GROUP BY 1
ORDER BY 1;
