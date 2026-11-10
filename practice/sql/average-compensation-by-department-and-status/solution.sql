WITH aggregated_sales AS (
  SELECT
    user_id,
    SUM(total_amount) AS total_sales
  FROM transactions
  GROUP BY user_id
),
aggregated_impressions AS (
SELECT
  user_id,
  SUM(revenue) AS total_revenue
FROM ad_impressions
WHERE user_id IS NOT NULL
GROUP BY user_id
)

SELECT
  u.account_status,
  AVG(COALESCE(agg_sales.total_sales, 0) + COALESCE(agg_imp.total_revenue, 0)) AS avg_total_value
FROM users AS u
LEFT JOIN aggregated_sales AS agg_sales
  ON u.user_id = agg_sales.user_id
LEFT JOIN aggregated_impressions AS agg_imp
  ON u.user_id = agg_imp.user_id
GROUP BY u.account_status
