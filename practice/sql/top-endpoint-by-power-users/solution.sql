SELECT 
    endpoint,
    COUNT(*) AS power_user_count
FROM (
    SELECT endpoint
    FROM api_calls
    WHERE user_id IS NOT NULL
    GROUP BY endpoint, user_id
    HAVING COUNT(*) FILTER (WHERE method IN ('GET', 'POST', 'PUT', 'DELETE')) * 2 >= COUNT(*)
) qualifying_users
GROUP BY endpoint
ORDER BY power_user_count DESC, endpoint ASC;
