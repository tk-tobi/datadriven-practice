-- SELECT * FROM transactions LIMIT 5;
SELECT
  user_id,
  total_amount,
  transaction_date
FROM (
  SELECT
    user_id,
    total_amount,
    transaction_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date) AS trn_rank,
    COUNT() OVER (PARTITION BY user_id) AS trn_count
  FROM transactions ) sub_table
WHERE trn_rank = 2 AND trn_count > 1
