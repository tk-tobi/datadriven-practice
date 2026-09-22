SELECT
  DISTINCT client
FROM rate_limits
WHERE blocked >= 1;
