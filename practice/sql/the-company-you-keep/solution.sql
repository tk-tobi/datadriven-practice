WITH shared_experiments AS (
  SELECT DISTINCT
    e1.exp_name
  FROM experiments AS e1
  INNER JOIN experiments AS e2
    ON e1.exp_name = e2.exp_name
    AND e1.user_id <> e2.user_id
),
co_enrolled_users AS (
  SELECT DISTINCT
    e.user_id
  FROM experiments AS e
  INNER JOIN shared_experiments AS s
    ON e.exp_name = s.exp_name
)
SELECT
  DATE(us.session_start) AS session_date,
  COUNT(*) AS total_sessions
FROM user_sessions AS us
INNER JOIN co_enrolled_users AS cu
  ON us.user_id = cu.user_id
WHERE CAST(
  STRFTIME('%w', us.session_start)
  AS INTEGER
  ) = 5
GROUP BY DATE(us.session_start)
ORDER BY session_date
