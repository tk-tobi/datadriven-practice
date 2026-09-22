WITH failed_calls AS (
  SELECT
    endpoint,
    status,
    LAG(status) OVER (PARTITION BY endpoint, user_id ORDER BY call_time ASC) AS prev_status,
    user_id,
    call_time,
    LAG(call_time) OVER (PARTITION BY endpoint, user_id ORDER BY call_time ASC) AS prev_call_time,
    (CAST(STRFTIME('%s', call_time) AS INTEGER) - CAST(STRFTIME('%s', LAG(call_time) OVER (PARTITION BY endpoint, user_id ORDER BY call_time ASC)) AS INTEGER)) / 60 AS time_diff
  FROM api_calls)
  
SELECT
  user_id,
  endpoint,
  COUNT(*) AS retry_count
FROM failed_calls
WHERE prev_status <> 200
  AND time_diff < 5
GROUP BY user_id, endpoint
ORDER BY COUNT(*) DESC, user_id, endpoint;
