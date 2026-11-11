-- SELECT * FROM svc_health LIMIT 10

SELECT
  region,
  SUM(effective_hours) AS total_effective_hours
FROM (
  SELECT
    region,
    uptime - (COALESCE(latency, 0) * 0.1) AS effective_hours
  FROM svc_health
  WHERE uptime IS NOT NULL
) sub_table
GROUP BY region
ORDER BY total_effective_hours DESC
LIMIT 3
