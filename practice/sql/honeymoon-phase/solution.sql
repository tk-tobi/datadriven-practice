-- SELECT * FROM users;
-- SELECT * FROM transactions;

SELECT
  SUBSTRING(u.signup_date, 1, 4) AS signup_year,
  ROUND(COUNT(*) FILTER (WHERE SUBSTRING(t.transaction_date, 1, 4) = SUBSTRING(u.signup_date, 1, 4)) * 1.0 
    /COUNT(*) * 100, 2)AS same_year_pct
FROM users AS u
JOIN transactions AS t
  ON u.user_id = t.user_id
GROUP BY SUBSTRING(u.signup_date, 1, 4)


/*
WITH user_yearly_txns AS (
    -- 1. Pre-aggregate the massive transactions table FIRST
    -- This shrinks millions of rows down to just a few rows per user
    SELECT 
        user_id,
        SUBSTRING(transaction_date, 1, 4) AS txn_year,
        COUNT(*) AS yearly_txn_count
    FROM transactions
    GROUP BY 
        user_id, 
        SUBSTRING(transaction_date, 1, 4)
)
-- 2. Join the tiny, aggregated results to the users table
SELECT 
    SUBSTRING(u.signup_date, 1, 4) AS signup_year,
    ROUND(
        SUM(t.yearly_txn_count) FILTER (WHERE t.txn_year = SUBSTRING(u.signup_date, 1, 4)) * 1.0 
        / SUM(t.yearly_txn_count) * 100, 
    2) AS same_year_pct
FROM users AS u
JOIN user_yearly_txns AS t 
    ON u.user_id = t.user_id
GROUP BY 
    SUBSTRING(u.signup_date, 1, 4);
*/
