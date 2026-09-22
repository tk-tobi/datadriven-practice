-- WITH recent_transaction AS (
--   SELECT
--     product_id,
--     user_id,
--     total_amount,
--     transaction_date,
--     ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY transaction_date DESC) AS rnk
--   FROM transactions
-- )
-- -- SELECT COUNT(*) FROM recent_transaction WHERE rnk =1
-- SELECT
--   p.product_name,
--   p.category,
--   rt.total_amount AS latest_sale_amount,
--   rt.transaction_date AS last_sale_date
-- FROM products AS p
-- JOIN recent_transaction AS rt
--   ON p.product_id = rt.product_id
-- WHERE rt.rnk = 1



WITH ranked AS (
  SELECT
    product_id,
    total_amount,
    transaction_date,
    ROW_NUMBER() OVER (
      PARTITION BY product_id
      ORDER BY transaction_date DESC, transaction_id DESC
    ) AS rn
  FROM transactions
)
SELECT
  p.product_name,
  p.category,
  r.total_amount AS latest_sale_amount,
  r.transaction_date AS last_sale_date
FROM products AS p
INNER JOIN ranked AS r
  ON r.product_id = p.product_id
WHERE r.rn = 1
ORDER BY p.product_name, p.product_id
