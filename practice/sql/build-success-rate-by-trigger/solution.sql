SELECT
  trigger,
  COUNT(*) AS total_builds,
  COUNT(build_id) FILTER (WHERE LOWER(status) = 'success') * 1.0 / COUNT(build_id) AS success_rate
FROM ci_builds
GROUP BY trigger;
