SELECT
    transaction_id,
    user_id,
    product_id,
    total_amount,
    transaction_date
FROM (
    SELECT
        transaction_id,
        user_id,
        product_id,
        total_amount,
        transaction_date,
        LAG(total_amount) OVER w AS prev_amount,
        LAG(transaction_date::DATE) OVER w AS prev_date
    FROM transactions
    WINDOW w AS (
        PARTITION BY user_id, product_id 
        ORDER BY transaction_date
    )
) sub
WHERE total_amount = prev_amount
  AND (transaction_date::DATE - prev_date) <= 35
ORDER BY transaction_date ASC;
