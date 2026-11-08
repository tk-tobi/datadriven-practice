WITH full_roaster AS (
  SELECT
    DISTINCT user_id
  FROM user_sessions
  
  UNION
  
  SELECT
    DISTINCT user_id
  FROM page_views
),
page_views_agg AS (
  SELECT
    user_id,
    COUNT(*) AS session_count,
    ROUND(SUM(session_duration_sec*1.0)/60) AS user_session_min
  FROM user_sessions
  WHERE EXTRACT(YEAR FROM session_start) >= 2026
  GROUP BY user_id
),

distinct_user_page AS (
  SELECT
    user_id,
    COUNT(DISTINCT(LOWER(page_url))) AS unique_content_count
  FROM page_views
  WHERE EXTRACT(YEAR FROM viewed_at) >= 2026
  GROUP BY user_id
  
)
SELECT
  fr.user_id AS user_id,
  COALESCE((pv.user_session_min), 0) AS total_minutes,
  COALESCE((du.unique_content_count), 0) AS unique_content_count
FROM full_roaster AS fr
LEFT JOIN page_views_agg AS pv
  ON fr.user_id = pv.user_id
LEFT JOIN distinct_user_page AS du
  ON fr.user_id = du.user_id
WHERE fr.user_id IS NOT NULL

-- WHERE us.user_id IS NOT NULL
-- AND EXTRACT(YEAR FROM session_start) >= 2026
-- GROUP BY us.user_id
