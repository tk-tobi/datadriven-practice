-- SELECT EXTRACT(DAY FROM impression_time), impression_time FROM ad_impressions;
-- SELECT * FROM ad_impressions;

SELECT
  EXTRACT(DAY FROM impression_time) AS day_of_month,
  AVG(revenue) AS avg_revenue,
  MAX(revenue) AS max_revenue,
  AVG(revenue) FILTER (WHERE clicked = 1) -
    AVG(revenue) FILTER (WHERE clicked = 0)
    AS click_premium
FROM ad_impressions
GROUP BY EXTRACT(DAY FROM impression_time)
ORDER BY 4;
