WITH signups AS (
  SELECT
    user_id,
    platform,
    DATE(created) AS signup_date
  FROM experiments
  WHERE DATE(created) BETWEEN '2026-01-01'
  AND '2026-01-07'
),
engagement AS (
  SELECT
    s.platform,
    s.signup_date,
    s.user_id,
    -- COUNT(*) FILTER (WHERE us.session_duration_sec > 0)
    CASE
      WHEN COUNT(
        CASE
          WHEN us.session_duration_sec > 0 THEN 1
        END
        ) > 0 THEN 1
      ELSE 0
    END AS converted
  FROM signups AS s
  LEFT JOIN user_sessions AS us
    ON s.user_id = us.user_id
    AND JULIANDAY(us.session_start) - JULIANDAY(
  s.signup_date
  ) BETWEEN 0
AND 7
  GROUP BY s.platform, s.signup_date, s.user_id
)
SELECT
  platform,
  signup_date,
  COUNT(*) AS total_users,
  SUM(converted) AS converted_users,
  CAST(SUM(converted) AS REAL) / CAST(
    COUNT(*)
    AS REAL
    ) * 100 AS conversion_rate
FROM engagement
GROUP BY platform, signup_date
ORDER BY platform, signup_date
