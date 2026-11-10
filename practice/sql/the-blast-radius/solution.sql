-- SELECT * FROM deploy_logs LIMIT 10;
-- SELECT * FROM svc_health LIMIT 10;
SELECT
  LOWER(d.author),
  ROUND(AVG(s.latency), 2) AS avg_score
FROM deploy_logs AS d
LEFT JOIN svc_health AS s
  ON d.svc_name = s.svc_name
GROUP BY LOWER(d.author)
ORDER BY 2 DESC
