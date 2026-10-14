-- SELECT * FROM api_calls LIMIT 5;
/*
For each user id, endpoint 
  detect the first failed call
  if success within 5 min, register failed calls + success time?
*/
WITH failed_calls AS (
  SELECT
    user_id,
    endpoint,
    status,
    call_time
  FROM api_calls
  WHERE user_id IS NOT NULL
    AND status LIKE '5%%'
  ORDER BY user_id
),
success_calls AS(
  SELECT
    user_id,
    endpoint,
    status,
    call_time
  FROM api_calls
  WHERE user_id IS NOT NULL
    AND status LIKE '2%%'
  ORDER BY user_id
),
later_calls AS (
  SELECT
    fc.user_id AS user_id,
    fc.endpoint AS endpoint,
    fc.call_time AS failed_call_time,
    sc.call_time AS retry_call_time
  FROM failed_calls AS fc
  JOIN success_calls AS sc
    ON fc.user_id = sc.user_id
    AND fc.endpoint = sc.endpoint
    AND fc.call_time <= sc.call_time
    AND fc.call_time >= (sc.call_time - INTERVAL '5 minute')
)
SELECT * FROM later_calls LIMIT 10;
