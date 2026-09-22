/*
API latency trend

AVG(latency)
GROUP BY endpoint, year
ORDER BY year, endpoint
*/

SELECT
  STRFTIME('%Y', call_time) AS year,
  endpoint,
  AVG(latency) AS avg_latency
FROM api_calls
GROUP BY 2, 1
ORDER BY 2, 1
