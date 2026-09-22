WITH campaign_metrics AS (
  SELECT
    ad_campaign,
    COUNT(*) AS impression_count,
    COUNT(*) FILTER (WHERE clicked = 1) AS clicks_count,
    COUNT(DISTINCT user_id) FILTER (WHERE clicked = 1) AS unique_clickers
  FROM ad_impressions
  GROUP BY ad_campaign
  HAVING COUNT(*) >= 3
),
conversion_metrics AS (
  SELECT
    *,
    JULIANDAY(transaction_date) - JULIANDAY(impression_time) AS date_diff
  FROM ad_impressions AS a
  JOIN transactions AS t
    ON a.user_id = t.user_id
  AND a.clicked = 1
  AND JULIANDAY(transaction_date) - JULIANDAY(impression_time) BETWEEN 0 AND 7
),
campaign_conversion AS (
  SELECT
    ad_campaign,
    COUNT(DISTINCT user_id) AS total_conversions
  FROM conversion_metrics
  GROUP BY ad_campaign
)

SELECT
  cm.ad_campaign,
  cm.impression_count AS impression_count,
  cm.clicks_count AS clicks,
  ROUND((cm.clicks_count * 100.0) / cm.impression_count, 2) AS ctr_pct,
  IFNULL(cc.total_conversions, 0) AS conversions,
  IFNULL((cc.total_conversions * 100.0)/cm.unique_clickers, 0) AS conversion_rate_pct
FROM campaign_metrics AS cm
LEFT JOIN campaign_conversion AS cc
  ON cm.ad_campaign = cc.ad_campaign
ORDER BY 6 DESC, 2 DESC
