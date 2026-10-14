SELECT 
    f.user_id,
    f.endpoint,
    f.call_time AS failed_call_time,
    r.call_time AS retry_call_time
FROM api_calls AS f
JOIN api_calls AS r
    ON f.user_id = r.user_id
    AND f.endpoint = r.endpoint
    AND r.call_time > f.call_time
    AND r.call_time <= f.call_time + INTERVAL '5 minute'
WHERE f.status BETWEEN 500 AND 599
  AND r.err_msg IS NULL;
