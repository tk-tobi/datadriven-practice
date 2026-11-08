SELECT
  ad_campaign,
  ROUND(SUM(clicked)*1.0 / COUNT(*) * 100, 2) AS rate,
  SUM(revenue) AS total_revenue,
  COUNT(*) AS impressions
FROM ad_impressions
GROUP BY ad_campaign
HAVING ROUND(SUM(clicked)*1.0 / COUNT(*) * 100, 3) > 20
ORDER BY 2 DESC
-- SELECT
--   ad_campaign,
--   SUM(clicked),
--   COUNT(*),
--   SUM(clicked)/COUNT(*) * 1.0 AS ctr_pct
-- FROM ad_impressions
-- GROUP BY ad_campaign
-- -- HAVING COUNT(clicked)/COUNT(*) > 0.2
