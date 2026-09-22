SELECT DISTINCT
  user_id,
  ad_campaign
FROM (
  SELECT
    user_id,
    ad_campaign,
    RANK() OVER (PARTITION BY user_id ORDER BY revenue DESC) AS rnk
  FROM ad_impressions
  WHERE clicked = 1
) sub_table
WHERE rnk = 1
