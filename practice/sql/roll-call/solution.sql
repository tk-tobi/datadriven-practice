SELECT
  first_name,
  last_name,
  country,
  NULL as status
FROM customers
ORDER BY first_name, last_name;
