-- SELECT * FROM ad_impressions;
WITH first_touch_impression AS (
  SELECT
    user_id,
    ad_campaign,
    impression_time,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY impression_time) AS rnk
  FROM ad_impressions
)

SELECT
  DISTINCT t.user_id,
  fti.ad_campaign,
  fti.impression_time
FROM transactions AS t
INNER JOIN first_touch_impression AS fti
  ON t.user_id = fti.user_id
WHERE fti.rnk = 1
ORDER BY t.user_id

-- SELECT COUNT(*) FROM first_touch_impression WHERE rnk = 1
