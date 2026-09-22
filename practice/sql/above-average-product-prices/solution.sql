WITH product_agg AS (
  SELECT
    product_id,
    MIN(total_amount) AS base_price
  FROM transactions
  GROUP BY product_id
)
  
SELECT
  *
FROM product_agg
WHERE base_price > (SELECT AVG(base_price) FROM product_agg);
