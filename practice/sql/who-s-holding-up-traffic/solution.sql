WITH daily_unique_users AS (
  SELECT
    endpoint,
    DATE(call_time) AS call_date,
    COUNT(DISTINCT user_id) AS unique_user_count
  FROM api_calls
  WHERE call_time >= '2026-06-01' AND call_time < '2026-07-01'
  GROUP BY 1, 2
)
  
SELECT
  endpoint,
  AVG(unique_user_count)
FROM daily_unique_users
GROUP BY endpoint;

-- SELECT * FROM api_calls;
