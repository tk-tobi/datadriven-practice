/*
constraint; fy 2026

SUM(revenue) AS earnings
GROUP BY campaign
ORDER BY earnings
*/

SELECT
  ad_campaign,
  SUM(revenue) AS total_revenue
FROM ad_impressions
WHERE STRFTIME('%Y', impression_time) = '2026'
GROUP BY ad_campaign
ORDER BY 2 DESC
