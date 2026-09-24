SELECT 
    pipe_name,
    MIN(start_at) AS first_run,
    MAX(start_at) AS last_run,
    COUNT(DISTINCT SUBSTR(start_at, 1, 7)) AS active_months
FROM data_pipes
GROUP BY pipe_name
ORDER BY pipe_name;
