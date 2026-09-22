-- SELECT * FROM products LIMIT 5;
SELECT
  product_name,
  price
FROM products
WHERE in_stock = 1
  AND price > 200
  AND category = 'Electronics'
ORDER BY price DESC
LIMIT 5
