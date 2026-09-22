WITH active_users AS(
  SELECT user_id
  FROM users
  WHERE account_status = 'active'
), april_transactions AS (
  SELECT user_id
  FROM transactions
  WHERE transaction_date >= '2026-04-01'
    AND transaction_date < '2026-05-01'
)
SELECT
  COUNT(DISTINCT u.user_id)
FROM active_users AS u
INNER JOIN april_transactions AS t
  ON u.user_id = t.user_id;


/* Checks */
-- SELECT * FROM users LIMIT 5; 
-- SELECT * FROM transactions LIMIT 5;
