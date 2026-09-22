-- SELECT * FROM page_views LIMIT 5;
WITH device_duration AS (
  SELECT
    LOWER(device) AS device,
    SUM(dur_ms) AS total_dwell_ms,
    SUM(SUM(dur_ms)) OVER () AS total_device_dwell
  FROM page_views
  GROUP BY LOWER(device)
)
-- SELECT * FROM device_duration;
SELECT
  device,
  total_dwell_ms,
  ROUND(SUM(total_dwell_ms * 1.0/ total_device_dwell) OVER (ORDER BY total_dwell_ms DESC) * 100, 2) AS running_pct
FROM device_duration
ORDER BY total_dwell_ms DESC;
