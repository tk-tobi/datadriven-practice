/*
campaign true reach: unique cicks

COUNT(DISTINCT())
ad_impressions
LEFT JOIN users
ORDER BY COUNT(*)

shape:
ad_campaign, users_reache
*/

SELECT
  ad_campaign,
  COUNT(DISTINCT(user_id)) FILTER (WHERE clicked = 1) AS users_reached
FROM ad_impressions
GROUP BY ad_campaign
ORDER BY 2 DESC;
