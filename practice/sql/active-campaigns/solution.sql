SELECT
  ad_campaign,
  COUNT(impression_time) AS impressions,
  SUM(revenue) AS total_revenue,
  ROUND(((SUM(clicked)*1.0)/COUNT(clicked))*100, 1) AS ctr
FROM ad_impressions
GROUP BY ad_campaign
HAVING impressions > 5
ORDER BY ctr DESC;


/* Check */
-- SELECT * FROM ad_impressions LIMIT 5;
