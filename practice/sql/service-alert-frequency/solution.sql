WITH alert_volume AS (
  SELECT
    svc_name,
    COUNT(*) AS alert_count
  FROM alert_events
  GROUP BY svc_name
)

SELECT
  svc_name,
  alert_count,
  DENSE_RANK() OVER (ORDER BY alert_count DESC) AS rnk
FROM alert_volume
ORDER BY 3, svc_name
