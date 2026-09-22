-- SELECT * FROM event_data LIMIT 5;
SELECT
  event_type,
  event_count AS total_events
FROM (
  SELECT
    event_type,
    COUNT(*) AS event_count,
    ROW_NUMBER() OVER (
      ORDER BY COUNT(*) DESC, event_type
    ) AS count_rnk
  FROM event_data
  GROUP BY 1
  HAVING COUNT(user_id) > (COUNT(*) - COUNT(user_id))
) sub_table
WHERE count_rnk <= 3
