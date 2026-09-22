WITH user_events AS (
    -- 1. Scan and aggregate the massive fact table FIRST
    SELECT 
        user_id,
        COUNT(*) FILTER (WHERE event_type IN ('error', 'timeout', 'crash')) AS bad_events,
        COUNT(*) AS total_events
    FROM event_data
    GROUP BY user_id
)
-- 2. Join the tiny, aggregated results to the users table
SELECT 
    u.account_status,
    SUM(ue.bad_events) * 1.0 / SUM(ue.total_events) AS negative_rate
FROM users AS u
INNER JOIN user_events AS ue 
    ON u.user_id = ue.user_id
GROUP BY u.account_status
ORDER BY negative_rate DESC;
