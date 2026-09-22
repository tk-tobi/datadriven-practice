SELECT
  ad_campaign,
  SUM(clicked) AS total_clicks,
  MAX(revenue) AS max_impression_revenue
FROM ad_impressions
GROUP BY ad_campaign
HAVING total_clicks >= 1
ORDER BY total_clicks DESC;
