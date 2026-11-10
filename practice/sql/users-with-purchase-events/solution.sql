SELECT
  DISTINCT e.user_id AS user_id
FROM event_data AS e
WHERE e.event_type = 'purchase'
ORDER BY 1
