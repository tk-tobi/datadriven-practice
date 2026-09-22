SELECT
  sessions AS session_count,
  COUNT(*) AS user_count
FROM (
  SELECT
    user_id,
    COUNT(session_id) AS sessions
  FROM user_sessions
  GROUP BY user_id) sub_table
GROUP BY sessions
ORDER BY session_count;
