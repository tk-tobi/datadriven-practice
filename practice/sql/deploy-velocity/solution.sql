WITH deploy_gap AS (
  SELECT
    svc_name,
    deploy_at,
    LAG(deploy_at) OVER (PARTITION BY svc_name ORDER BY deploy_at) AS prev_deploy,
    DATEDIFF(day, LAG(deploy_at) OVER (PARTITION BY svc_name ORDER BY deploy_at), deploy_at) AS days_diff
  FROM deploy_logs
)

SELECT
  svc_name,
  AVG(days_diff)
FROM deploy_gap
GROUP BY svc_name
