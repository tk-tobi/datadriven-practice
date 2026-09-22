/* Check */
SELECT
  log_id,
  server_name,
  log_level,
  message,
  response_time_ms,
  log_timestamp
FROM (
  SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY server_name, message ORDER BY log_timestamp DESC) AS rn
  FROM server_logs ) sub_table
  WHERE rn = 1
  AND log_timestamp >= datetime('now', '-7 days');
