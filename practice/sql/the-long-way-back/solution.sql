/*

*/
WITH monthly AS (
    SELECT svc_name, strftime('%Y-%m', checked) AS month, AVG(uptime) AS avg_uptime
    FROM svc_health
    WHERE uptime IS NOT NULL
    GROUP BY svc_name, strftime('%Y-%m', checked)
),
with_lag AS (
    SELECT svc_name, month, avg_uptime,
        LAG(avg_uptime) OVER (PARTITION BY svc_name ORDER BY month) AS prev_uptime
    FROM monthly
),
trends AS (
    SELECT svc_name, month, avg_uptime, prev_uptime,
        CASE
            WHEN avg_uptime < prev_uptime THEN 'decline'
            WHEN avg_uptime > prev_uptime THEN 'growth'
            ELSE 'flat'
        END AS trend
    FROM with_lag
    WHERE prev_uptime IS NOT NULL
),
numbered AS (
    SELECT svc_name, month, avg_uptime, trend,
        ROW_NUMBER() OVER (PARTITION BY svc_name ORDER BY month) AS rn
    FROM trends
),
groups AS (
    SELECT svc_name, month, avg_uptime, trend,
        rn - ROW_NUMBER() OVER (PARTITION BY svc_name, trend ORDER BY month) AS grp
    FROM numbered
),
streaks AS (
    SELECT svc_name, trend, grp,
        MIN(month) AS start_month,
        MAX(month) AS end_month,
        MIN(avg_uptime) AS min_uptime,
        MAX(avg_uptime) AS max_uptime
    FROM groups
    GROUP BY svc_name, trend, grp
),
decline_then_growth AS (
    SELECT
        d.svc_name,
        d.start_month AS decline_start,
        g.start_month AS growth_start,
        CAST((g.max_uptime - d.min_uptime) AS DOUBLE) / d.min_uptime AS growth_ratio
    FROM streaks d
    INNER JOIN streaks g
        ON d.svc_name = g.svc_name
       AND d.trend = 'decline'
       AND g.trend = 'growth'
       AND g.start_month > d.end_month
)
SELECT svc_name, decline_start, growth_start, growth_ratio
FROM decline_then_growth;
