
-- WITH user_signup_day AS (
--   SELECT
--     user_id,
--     transaction_date,
--     COUNT(*) AS new_customers
--   FROM transactions
--   GROUP BY transaction_date
--   QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) = 1
  
-- )

-- SELECT transaction_date, new_customers FROM user_signup_day;

WITH first_orders AS (
  SELECT
    user_id,
    MIN(transaction_date) AS first_date
  FROM transactions
  GROUP BY user_id
)

SELECT
  first_date AS transaction_date,
  COUNT(user_id) AS new_customers
FROM first_orders
GROUP BY first_date;
