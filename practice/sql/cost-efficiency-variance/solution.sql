WITH svc_per_region AS (
  SELECT
    region,
    COUNT(DISTINCT svc_name) AS svc_count
  FROM cloud_costs
  GROUP BY region
),
cps_ratio AS (
  SELECT
    *,
    SUBSTRING(bill_date, 1, 7) AS ym,
    amount/svc_count AS cps
  FROM cloud_costs AS c
  JOIN svc_per_region AS s
    ON c.region = s.region
),
monthly_avg AS (
  SELECT
    ym,
    AVG(cps) AS month_avg
  FROM cps_ratio
  GROUP BY ym
), diffs AS (
  SELECT
    c.ym,
    c.cps AS actual_ratio,
    m.month_avg AS monthly_average,
    ABS(c.cps - m.month_avg) AS abs_diff
  FROM cps_ratio AS c
  JOIN monthly_avg AS m
    ON c.ym = m.ym
)
SELECT 
   ym,
   ROUND(AVG(actual_ratio), 3) AS actual_ratio,
   ROUND(AVG(monthly_average), 3) AS monthly_avg,
   ROUND(AVG(abs_diff), 3) AS avg_abs_difference
FROM diffs
GROUP BY ym
