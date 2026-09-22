WITH most_recent_session AS (
  SELECT
    user_id,
    MAX(session_start) AS last_session
  FROM user_sessions
  GROUP BY user_id
),
total_transactions AS (
  SELECT
    user_id,
    SUM(total_amount) AS total_spend
  FROM transactions
  GROUP BY user_id
)

SELECT
  u.username,
  u.account_status,
  mrs.last_session AS last_login,
  COALESCE(tt.total_spend, 0) AS lifetime_spend
FROM users AS u
LEFT JOIN most_recent_session AS mrs
  ON u.user_id = mrs.user_id
LEFT JOIN total_transactions AS tt
  ON tt.user_id = u.user_id
WHERE u.account_status = 'active'
  AND mrs.last_session < DATE('now', '-90 days')
