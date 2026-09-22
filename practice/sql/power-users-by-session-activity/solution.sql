WITH power_sessions AS (
    SELECT 
        user_id, 
        COUNT(session_id) AS session_count, 
        SUM(pages_viewed) AS total_pages
    FROM user_sessions
    GROUP BY user_id
    HAVING COUNT(session_id) > 3 
       AND SUM(pages_viewed) > 100
)
SELECT 
    u.user_id, 
    u.username, 
    p.session_count, 
    p.total_pages
FROM users u
INNER JOIN power_sessions p 
    ON u.user_id = p.user_id
WHERE u.account_status = 'active'
ORDER BY p.total_pages DESC;
