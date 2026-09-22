WITH user_revenue AS (
    SELECT 
        user_id,
        SUM(revenue) AS total_user_revenue
    FROM ad_impressions
    GROUP BY user_id
)
SELECT 
    u.age_bucket AS age_bucket,
    SUM(r.total_user_revenue) AS total_revenue
FROM user_revenue AS r
INNER JOIN users AS u 
    ON r.user_id = u.user_id
WHERE u.age_bucket IS NOT NULL
GROUP BY u.age_bucket
ORDER BY total_revenue DESC;
