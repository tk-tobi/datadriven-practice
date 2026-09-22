-- SELECT * FROM ci_builds;

SELECT
  DATE(built_at, 'weekday 0', '-6 days') AS week_start,
  COUNT(*) FILTER (WHERE status = 'success') AS success_count,
  COUNT(*) FILTER (WHERE status = 'failed') AS failed_count,
  COUNT(*) FILTER (WHERE status = 'canceled') AS canceled_count 
FROM ci_builds
WHERE EXTRACT(YEAR FROM built_at) = 2026
  AND status IN ('success', 'failed', 'canceled')
GROUP BY week_start
ORDER BY week_start
