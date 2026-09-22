SELECT
  endpoint,
  latency,
  AVG(latency) OVER (
    PARTITION BY endpoint ORDER BY call_time, call_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_avg
FROM api_calls
WHERE latency IS NOT NULL
ORDER BY call_time DESC, call_id
