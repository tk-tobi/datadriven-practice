-- SELECT * FROM push_notifs LIMIT 5;
WITH select_days AS (
SELECT
  DATE_TRUNC('day', sent_at) AS sent_day,
  COUNT(DISTINCT user_id) AS unique_users
FROM push_notifs
WHERE sent_at BETWEEN '2026-08-01' AND '2026-08-07'
GROUP BY 1
)

SELECT
  EXTRACT(DOW FROM sent_day) AS day_name,
  sent_day,
  unique_users
FROM select_days
