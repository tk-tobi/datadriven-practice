SELECT
  COALESCE(severity, 'unknown') AS severity_tier,
  COUNT(*) AS alert_count
FROM alert_events
GROUP BY severity_tier
ORDER BY alert_count DESC;


/* Checks */
-- SELECT * FROM alert_events LIMIT 5;
