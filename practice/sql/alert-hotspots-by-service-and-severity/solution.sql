SELECT
  svc_name,
  severity,
  COUNT(*) AS alert_count
FROM alert_events
GROUP BY svc_name, severity
ORDER BY 3 DESC;
