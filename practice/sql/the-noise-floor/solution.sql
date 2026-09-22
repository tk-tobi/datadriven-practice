SELECT
  svc_name,
  ROUND(
    (COUNT(*) FILTER (WHERE severity IN ('high', 'critical', 'HIGH', 'Critical'))*1.0/
    COUNT(*))*100, 1)
    AS high_urgency_pct
FROM alert_events
GROUP BY svc_name
HAVING high_urgency_pct > 50.0
ORDER BY high_urgency_pct DESC, svc_name;
