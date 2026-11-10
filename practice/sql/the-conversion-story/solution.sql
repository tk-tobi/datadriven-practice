WITH event_data_classified AS (
SELECT
  DISTINCT user_id,
  CASE
    WHEN tags LIKE '%"organic"%' THEN "organic"
    WHEN tags LIKE '%referral%' THEN "referral"
    WHEN tags LIKE '%campaign_a%' THEN "campaign_a"
    WHEN tags LIKE '%campaign_b%' THEN "campaign_b"
    ELSE "other"
    END AS referral_source,
  event_type
FROM event_data),

referral_sources AS (
SELECT
  referral_source,
  SUM(
    CASE
      WHEN event_type = 'signup' THEN 1
    ELSE 0
    END
  ) AS signup_users,
  SUM(
    CASE
      WHEN event_type = 'purchase' THEN 1
    ELSE 0
    END
  ) AS purchase_users
FROM event_data_classified
GROUP BY referral_source
)
SELECT
  referral_source,
  signup_users,
  purchase_users,
  signup_users + purchase_users AS funnel_users,
  ROUND(purchase_users*1.0/signup_users, 4) AS conversion_rate
FROM referral_sources
WHERE signup_users > 0
