/*
Ordered pair 
  self join

shape:
product_name_a, product_name_b, category, price_a, price_b 
*/

SELECT
  p1.product_name AS product_1,
  p2.product_name AS product_2,
  p1.category AS category,
  p1.price AS price_1,
  p2.price AS price_2
FROM products AS p1
JOIN products AS p2
  ON p1.category = p2.category
  AND p2.price >= (p1.price * 2)
  -- AND p1.product_name < p2.product_name
ORDER BY p1.price, p1.product_name
-- LIMIT 10;
