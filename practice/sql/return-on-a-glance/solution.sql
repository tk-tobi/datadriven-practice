
SELECT
  SUM(revenue)/COUNT(*) AS avg_revenue_per_impression
FROM ad_impressions
WHERE ad_campaign LIKE '%brand%';


/* Checks */
-- SELECT * FROM ad_impressions LIMIT 5;
-- SELECT COUNT(DISTINCT ad_campaign) FROM ad_impressions;
-- SELECT COUNT(ad_campaign) FROM ad_impressions;
-- SELECT * FROM aggregated_campaigns LIMIT 5;
