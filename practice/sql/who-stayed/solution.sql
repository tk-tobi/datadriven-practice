WITH dedup_days AS (
  SELECT DISTINCT
    user_id,
    DATE(session_start) AS visit_day
  FROM user_sessions
  WHERE session_start <= DATE('2026-08-10')
), 
consecutive_days AS (
  SELECT
    user_id,
    visit_day,
    visit_day - ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY visit_day) AS groupkey
  FROM dedup_days
),
streak_count AS (
  SELECT
    user_id,
    COUNT(*) AS streak_length
  FROM consecutive_days
  GROUP BY user_id, groupkey
)
SELECT 
  DISTINCT user_id, 
  streak_length
FROM streak_count
WHERE streak_length = 1;

/* Checks */
-- SELECT COUNT(DISTINCT session_start) FROM user_sessions;
-- SELECT COUNT(DISTINCT visit_day) FROM dedup_days;
-- SELECT * FROM consecutive_days ORDER BY user_id LIMIT 20;
-- SELECT DISTINCT user_id FROM streak_count LIMIT 20;
