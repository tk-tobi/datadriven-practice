-- SELECT * FROM alert_events 
-- SELECT * FROM svc_health WHERE svc_name = 'payment-api'


WITH svc_health_check AS (
  SELECT
    svc_name,
    MIN(checked) AS earliest_check
    -- FIRST_VALUE(checked) OVER (PARTITION BY svc_name ORDER BY checked) AS earliest_check
  FROM svc_health
  GROUP BY svc_name
)
  
SELECT 
  a.svc_name,
  SUM(CAST(DATEDIFF(MINUTE, fired_at, resolved) * 1440 AS INTEGER))
FROM alert_events AS a
JOIN svc_health_check AS s
  ON s.svc_name = a.svc_name
-- WHERE a.fired_at <= JULIANDAY(s.earliest_check, '+1 year')
WHERE a.fired_at <= DATETIME(s.earliest_check, '+365 days')
AND a.resolved IS NOT NULL
GROUP BY a.svc_name
