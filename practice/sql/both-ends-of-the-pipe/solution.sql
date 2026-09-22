-- SELECT * FROM deploy_logs LIMIT 5;
SELECT
  author,
  COUNT(DISTINCT LOWER(env_name)) AS env_count 
FROM deploy_logs 
WHERE LOWER(env_name) IN ('dev', 'production')
GROUP BY author
HAVING env_count > 0
ORDER BY author;
