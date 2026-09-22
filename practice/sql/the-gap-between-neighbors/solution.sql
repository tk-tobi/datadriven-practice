-- SELECT * FROM svc_health LIMIT 5;
WITH qualifying_health_check AS (
  SELECT
    *
  FROM svc_health
  WHERE status = 'healthy'
),
other_health_check AS (
  SELECT
    *
  FROM svc_health
  WHERE status != 'healthy'
    AND LOWER(status) = 'healthy'
),
compare_valid_checks AS (
  SELECT
    q.svc_name AS svc_name,
    q.latency AS svc_latency,
    q.uptime AS svc_uptime,
    nq.svc_name AS compare_svc_name,
    nq.latency AS compare_svc_latency,
    nq.uptime AS compare_svc_uptime,
    ABS(q.latency - nq.latency) AS latency_gap
  FROM qualifying_health_check AS q
  JOIN qualifying_health_check AS nq
    ON q.region = nq.region
    AND q.check_id <> nq.check_id
  WHERE ABS(q.uptime - nq.uptime) <= 5
)
SELECT
  svc_name,
  AVG(latency_gap)
FROM compare_valid_checks
GROUP BY svc_name
-- SELECT * FROM compare_valid_checks
