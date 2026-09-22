WITH monthly_deploy_agg AS (
  SELECT
    svc_name,
    SUBSTRING(deploy_at, 1, 7) AS deploy_month,
    COUNT(*) AS deployment_count
  FROM deploy_logs
  GROUP BY svc_name, SUBSTRING(deploy_at, 1, 7)
),
prev_month_agg AS (
  SELECT
    svc_name,
    deployment_count,
    deploy_month,
    LAG(deployment_count) OVER (
      PARTITION BY svc_name
      ORDER BY deploy_month) AS prev_month_deploy_count,
    ROW_NUMBER() OVER (PARTITION BY svc_name
      ORDER BY deploy_month) AS rnk
  FROM monthly_deploy_agg)
SELECT
  svc_name,
  deploy_month,
  deployment_count,
  prev_month_deploy_count,
  ROUND((deployment_count - prev_month_deploy_count)*1.0/
    NULLIF(prev_month_deploy_count, 0)*100, 2) AS deploy_vel
FROM prev_month_agg
WHERE rnk <> 1
-- SELECT * FROM monthly_deploy_agg LIMIT 5;
