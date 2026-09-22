WITH product_averages AS (
  SELECT
    p.product_name,
    AVG(t.total_amount) AS product_average,
    AVG(t.total_amount) OVER (PARTITION BY p.category) AS category_average
  FROM transactions AS t
  INNER JOIN products AS p
    ON t.product_id = p.product_id
  GROUP BY p.product_name
)
  
SELECT
  product_name,
  product_average,
  category_average
FROM product_averages
WHERE product_average >= category_average;

-- SELECT COUNT(*) FROM products;
-- SELECT COUNT(*) FROM transactions:
