WITH error_counter AS (
  SELECT
    first_at::DATE AS error_date,
    COUNT(*) AS error_count
  FROM err_tracks 
  GROUP BY error_date
)

SELECT
  error_date,
  error_count,
  LAG(error_count) OVER (ORDER BY error_date) AS prev_count,
  error_count - LAG(error_count) OVER (ORDER BY error_date) AS day_over_day_change
FROM error_counter
ORDER BY error_date

/* Checks */
-- SELECT * FROM err_tracks LIMIT 10;
