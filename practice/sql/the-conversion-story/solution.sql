WITH sourced_events AS (
  SELECT
    user_id,
    event_type,
    CASE
      WHEN tags LIKE '%"organic"%' THEN 'organic'
      WHEN tags LIKE '%"referral"%' THEN 'referral'
      WHEN tags LIKE '%"campaign_a"%' THEN 'campaign_a'
      WHEN tags LIKE '%"campaign_b"%' THEN 'campaign_b'
      ELSE 'other'
    END AS referral_source
  FROM event_data
  WHERE event_type IN ('signup', 'purchase')
),
source_funnel AS (
  SELECT
    referral_source,
    COUNT(DISTINCT 
      CASE
        WHEN event_type = 'signup' THEN user_id
      END
    ) AS signup_users,
    COUNT(DISTINCT 
      CASE
        WHEN event_type = 'purchase' THEN user_id
      END
    ) AS purchase_users,
    COUNT(DISTINCT user_id) AS funnel_users
  FROM sourced_events
  GROUP BY referral_source
  HAVING COUNT(
    CASE
      WHEN event_type = 'signup' THEN 1
    END
  ) > 0
)

SELECT
  referral_source,
  signup_users,
  purchase_users,
  funnel_users,
  ROUND(purchase_users * 1.0 / signup_users, 4) AS conversion_rate
FROM source_funnel
ORDER BY referral_source
