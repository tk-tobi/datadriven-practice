-- SELECT * FROM k8s_pods LIMIT 10;
SELECT
  status,
  COUNT(*) AS pod_count
FROM k8s_pods
WHERE restarts = 0
GROUP BY status
ORDER BY 2 DESC, 1
