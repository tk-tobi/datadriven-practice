-- -- product category w/ highest sale, w/ lowest sales
-- /*
-- category_name | total
-- */
-- WITH product_sales AS (
--   SELECT
--     category,
--     SUM(total_amount) AS total_sales
--   FROM products AS p
--   INNER JOIN transactions AS t
--     ON p.product_id = t.product_id
--   WHERE SUBSTRING(transaction_date, 1,4) = '2026'
--   GROUP BY category
-- ),
-- agg_sales AS (

-- SELECT
--   category,
--   MAX(total_sales) AS total
-- FROM product_sales

-- UNION ALL
  
-- SELECT
--   category,
--   MIN(total_sales) AS total
-- FROM product_sales
-- )

-- -- SELECT * FROM agg_sales;

-- SELECT
--   category,
--   total_sales
-- FROM product_sales
-- WHERE total_sales = (SELECT MAX(total_sales) FROM product_sales)
-- OR total_sales = (SELECT MIN(total_sales) FROM product_sales)


WITH category_totals AS (
    SELECT 
        p.category, 
        SUM(t.total_amount) AS total
    FROM products AS p
    JOIN transactions AS t 
        ON p.product_id = t.product_id
    WHERE t.transaction_date >= '2026-01-01' 
      AND t.transaction_date < '2027-01-01'
    GROUP BY p.category
)
SELECT 
    category, 
    total
FROM category_totals
WHERE total = (SELECT MAX(total) FROM category_totals)
   OR total = (SELECT MIN(total) FROM category_totals);
  
