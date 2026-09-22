SELECT
  endpoint,
  latency,
  CASE
    WHEN latency < 100 THEN 'fast'
    WHEN latency BETWEEN 100 AND 500 THEN 'normal'
    ELSE 'slow'
  END AS latency_cat
FROM api_calls
WHERE latency IS NOT NULL
