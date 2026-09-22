WITH filtered_impressions AS (
  SELECT *
  FROM ad_impressions
  WHERE ad_campaign = 'HOLIDAY_PROMO'
)

SELECT
  a.impression_id,
  a.user_id,
  a.ad_campaign,
  a.impression_time,
  a.clicked,
  a.revenue,
  u.username,
  u.email,
  u.signup_date,
  u.account_status,
  u.age_bucket
FROM filtered_impressions AS a
LEFT JOIN users AS u
  ON a.user_id = u.user_id; 
