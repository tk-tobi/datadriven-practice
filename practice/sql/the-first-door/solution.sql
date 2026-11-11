SELECT DISTINCT
  user_id,
  FIRST_VALUE(event_name) OVER (PARTITION BY user_id ORDER BY event_ts) AS first_event
FROM app_event_deliveries
WHERE user_id IS NOT NULL
-- LIMIT 10;
