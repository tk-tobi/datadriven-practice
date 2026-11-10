-- SELECT * FROM devices WHERE device_type = 'mobile' LIMIT 10;
SELECT
  d.os_name,
  AVG(u.session_duration_sec) AS avg_duration
FROM devices AS d
JOIN user_sessions AS u
  ON d.device_id = u.device_id
WHERE d.device_type = 'mobile'
GROUP BY d.os_name
ORDER BY 2 DESC
LIMIT 1
