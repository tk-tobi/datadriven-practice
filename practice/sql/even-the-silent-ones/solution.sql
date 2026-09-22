/* Can't Prevent Fanout */
-- SELECT
--   username,
--   IFNULL(COUNT(DISTINCT session_id), 0) AS session_count,
--   IFNULL(SUM(t.total_amount), 0) AS total_amount
-- FROM users AS u
-- LEFT JOIN user_sessions AS s
--   ON u.user_id = s.user_id
-- LEFT JOIN transactions AS t
--   ON u.user_id = t.user_id
-- GROUP BY username
-- ORDER BY 2

-- WITH sum_agg AS (
--   SELECT
--     u.user_id,
--     u.username,
--     SUM(total_amount) AS total
--   FROM users AS u
--   LEFT JOIN transactions AS t
--     ON u.user_id = t.user_id
--   GROUP BY u.user_id, u.username
-- )
 
-- SELECT
--   s.username,
--   IFNULL(COUNT(DISTINCT session_id), 0) AS session_count,
--   ROUND(IFNULL(MAX(total), 0), 3) AS total_amount
-- FROM sum_agg AS s
-- LEFT JOIN user_sessions AS u
--   ON s.user_id = u.user_id
-- GROUP BY s.username
-- ORDER BY 2 DESC, 1

WITH session_agg AS (
  SELECT
    user_id,
    COUNT(*) AS session_count
  FROM user_sessions
  GROUP BY user_id
),
txn_agg AS (
  SELECT
    user_id,
    SUM(total_amount) AS total_amount
  FROM transactions
  GROUP BY user_id
)
SELECT
  u.username,
  COALESCE(sa.session_count, 0) AS session_count,
  COALESCE(ta.total_amount, 0) AS total_amount
FROM users AS u
LEFT JOIN session_agg AS sa
  ON u.user_id = sa.user_id
LEFT JOIN txn_agg AS ta
  ON u.user_id = ta.user_id
