-- SELECT
--   p.product_name
-- FROM products AS p
-- LEFT JOIN transactions AS t
--   ON p.product_id = t.product_id
-- WHERE t.transaction_id IS NULL

--

SELECT
  product_name
FROM products AS p
WHERE NOT EXISTS (
  SELECT 1
  FROM transactions AS t
  WHERE p.product_id = t.product_id)
