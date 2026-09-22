SELECT
  p.category,
  ROUND((SUM(t.total_amount) * 1.0 /SUM(SUM(t.total_amount)) OVER ()) * 100, 2) AS revenue_share_pct
FROM transactions AS t
JOIN products AS p
  ON t.product_id = p.product_id
GROUP BY p.category
ORDER BY 2 DESC 
