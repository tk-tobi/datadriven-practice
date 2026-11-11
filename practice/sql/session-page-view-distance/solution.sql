WITH session_views AS (
  SELECT
    us.session_id,
    FIRST_VALUE(pv.dur_ms) OVER (
      PARTITION BY us.session_id
      ORDER BY pv.view_id ASC
    ) AS first_dur,
    LAST_VALUE(pv.dur_ms) OVER (
      PARTITION BY us.session_id
      ORDER BY pv.view_id ASC
      ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_dur,
    COUNT(pv.view_id) OVER (
      PARTITION BY us.session_id
    ) AS view_count
  FROM user_sessions us
  JOIN page_views pv
    ON us.user_id = pv.user_id
  WHERE pv.view_id IS NOT NULL
),
session_distances AS (
  SELECT DISTINCT
    session_id,
    last_dur - first_dur AS diff
  FROM session_views
  WHERE view_count > 1
    AND first_dur IS NOT NULL
    AND last_dur IS NOT NULL
)
SELECT
  AVG(diff) AS avg_distance
FROM session_distances;
