WITH first_and_last_day AS (
SELECT
  ad_campaign,
  MIN(CAST(impression_time AS DATE)) AS first_day,
  MAX(CAST(impression_time AS DATE)) AS last_day
FROM ad_impressions
GROUP BY ad_campaign
)

SELECT
  a.ad_campaign,
  ROUND(COUNT(*) FILTER (WHERE CAST(a.impression_time AS DATE) = f.first_day) * 1.0 / COUNT(*) * 100, 3) AS first_day_pct,
  ROUND(COUNT(*) FILTER (WHERE CAST(a.impression_time AS DATE) = f.last_day) * 1.0 / COUNT(*) * 100, 3) AS last_day_pct
FROM ad_impressions AS a
JOIN first_and_last_day AS f
  ON a.ad_campaign = f.ad_campaign
GROUP BY a.ad_campaign

-- WHERE CAST(a.impression_time AS DAY) IN (f.first_day, f.last_day)

-- SELECT
--   *,
--   CAST(impression_time AS DAY)
-- FROM ad_impressions AS a
-- JOIN first_and_last_day AS f
--   ON a.ad_campaign = f.ad_campaign
-- -- GROUP BY a.ad_campaign
