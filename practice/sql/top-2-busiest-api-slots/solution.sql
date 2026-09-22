/*
FILTER: Morning, Early Afternoon, Late Afternoon
EXTRACT(day of week) as dow

GROUP BY dow, segment
ORDER BY SUM(call)
DENSE_RANK() <= 2
*/
-- SELECT * FROM api_calls LIMIT 5;
WITH api_calls_segments AS (
  SELECT
    CASE
      WHEN CAST(SUBSTRING(call_time, 12, 22) AS TIME) < '12:00' THEN 'Morning'
      WHEN CAST(SUBSTRING(call_time, 12, 22) AS TIME) BETWEEN '12:00' AND '15:00' THEN 'Early Afternoon'
      ELSE 'Late Afternoon'
      END AS time_segment,
    EXTRACT(DOW FROM call_time) AS dow
  FROM api_calls
),
day_segment_groups AS (
  SELECT
    dow,
    time_segment,
    COUNT(*) AS call_count
  FROM api_calls_segments
  GROUP BY dow, time_segment
)
SELECT
  dow AS day_of_week,
  time_segment,
  call_count
FROM (
  SELECT
    dow,
    time_segment,
    call_count,
    DENSE_RANK() OVER (ORDER BY call_count DESC) AS rnk
  FROM day_segment_groups
) sub_table
WHERE rnk <= 2
