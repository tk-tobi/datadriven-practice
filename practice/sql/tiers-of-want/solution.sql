WITH user_baskets AS (
  SELECT
    t.user_id,
    p.category,
    SUM(t.total_amount) AS total_sales,
    COUNT(*) AS txn_count,
    SUM(t.total_amount) * 1 / COUNT(
      *
      ) AS basket_size,
    CASE
      WHEN SUM(t.total_amount) * 1 / COUNT(
        *
        ) > 500 THEN 'High'
      WHEN SUM(t.total_amount) * 1 / COUNT(
        *
        ) >= 200 THEN 'Medium'
      ELSE 'Low'
    END AS segment
  FROM transactions AS t
  INNER JOIN products AS p
    ON t.product_id = p.product_id
  GROUP BY t.user_id, p.category
)
SELECT
  category,
  segment,
  COUNT(*) AS unique_users,
  SUM(txn_count) AS total_transactions,
  SUM(total_sales) AS total_sales,
  AVG(basket_size) AS avg_basket_size
FROM user_baskets
GROUP BY category, segment
