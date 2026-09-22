SELECT
  category,
  COUNT(*) AS product_count
FROM products
GROUP BY category
HAVING COUNT(*) > 8
ORDER BY product_count DESC;
