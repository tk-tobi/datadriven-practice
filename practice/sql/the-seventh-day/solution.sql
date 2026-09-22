WITH signup_cohorts AS (
  SELECT
    STRFTIME('%Y-W%W', signup_date) AS cohort_week,
    COUNT(DISTINCT u.user_id) as total_signups,
    COUNT(DISTINCT u.user_id) FILTER (WHERE JULIANDAY(p.viewed_at) - JULIANDAY(u.signup_date) >= 7) AS retained_users
  FROM users AS u
  LEFT JOIN page_views AS p
    ON u.user_id = p.user_id
  WHERE JULIANDAY('NOW') - JULIANDAY(u.signup_date) >= 7
  GROUP BY cohort_week)
  
SELECT 
  cohort_week,
  total_signups,
  retained_users,
  ROUND(retained_users*1.0/total_signups * 100, 1) AS retention_pct 
FROM signup_cohorts 
ORDER BY cohort_week;
