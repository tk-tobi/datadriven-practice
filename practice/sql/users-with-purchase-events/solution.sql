SELECT
  DISTINCT e.user_id AS user_id
FROM event_data AS e
LEFT JOIN users AS u
  ON e.user_id = u.user_id
WHERE e.event_type = 'purchase'
  AND e.user_id IS NOT NULL
ORDER BY 1
