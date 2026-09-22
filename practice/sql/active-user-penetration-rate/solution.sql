-- SELECT * FROM user_sessions LIMIT 20;
-- SELECT * FROM devices LIMIT 20;

WITH latest_session AS (
  SELECT
    MAX(session_start) AS latest_session
  FROM user_sessions
),
session_aggregate AS (
  SELECT
    u.user_id,
    d.device_type AS device_type,
    SUM(session_duration_sec) AS combined_session,
    COUNT(session_id) AS logged_session_count,
    MAX(session_start) AS most_recent_session
  FROM user_sessions AS u
  JOIN devices AS d
    ON u.device_id = d.device_id
  GROUP BY d.device_type, u.user_id
)

SELECT
  device_type,
  COUNT(*) FILTER (
        WHERE most_recent_session > DATE((SELECT * FROM latest_session), '-30 days')
        AND combined_session > 36000
        AND logged_session_count > 5) * 1.0
  / COUNT(DISTINCT user_id) * 100 AS penetration_rate
FROM session_aggregate
GROUP BY device_type
