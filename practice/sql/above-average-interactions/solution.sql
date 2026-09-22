WITH user_count AS (
  SELECT
    user_id,
    COUNT(*) AS session_count
  FROM user_sessions
  GROUP BY user_id
)

SELECT
  *
FROM user_count AS u
WHERE session_count > (SELECT SUM(session_count) * 1.0/ COUNT(*) FROM user_count)
