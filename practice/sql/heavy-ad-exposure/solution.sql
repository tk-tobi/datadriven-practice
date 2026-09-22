WITH impression_count AS (
SELECT
  user_id,
  ad_campaign,
  COUNT(*)
FROM ad_impressions
GROUP BY ad_campaign, user_id
HAVING COUNT(*) >= 3)

SELECT
  DISTINCT user_id
FROM impression_count
WHERE user_id IS NOT NULL
ORDER BY user_id
