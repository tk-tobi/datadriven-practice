WITH failed_calls AS (
    SELECT user_id, endpoint, call_time
    FROM api_calls
    WHERE status BETWEEN 500 AND 599
    ORDER BY user_id
),
success_calls AS (
    SELECT user_id, endpoint, call_time
    FROM api_calls
    WHERE status BETWEEN 200 AND 299
    ORDER BY user_id
)
SELECT 
    fc.user_id,
    fc.endpoint,
    fc.call_time AS failed_call_time,
    sc.call_time AS retry_call_time
FROM failed_calls fc
JOIN success_calls sc
    ON fc.user_id = sc.user_id
    AND fc.endpoint = sc.endpoint
    AND fc.call_time < sc.call_time
    AND fc.call_time >= sc.call_time - INTERVAL '5 minute';
