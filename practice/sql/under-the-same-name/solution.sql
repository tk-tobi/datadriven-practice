/*
LOWER(status)
AVG(latency)
GROUP BY LOWER(status)
ORDER BY avg_lat DESC
*/

SELECT
  LOWER(status) AS status,
  AVG(latency) AS avg_latency
FROM svc_health
GROUP BY 1
ORDER BY 2 DESC
-- LIMIT 5;
