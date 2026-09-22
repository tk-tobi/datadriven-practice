/*
-- SELECT * FROM cost_allocs LIMIT 5;
WITH svc_region_allocations AS (
  SELECT
    svc_name,
    region,
    SUM(amount) AS budget
  FROM cost_allocs
  GROUP BY svc_name, region
),
cloud_spend AS (
  SELECT
    svc_name,
    region,
    SUM(amount) AS cloud_spend
  FROM cloud_costs
  GROUP BY svc_name, region
)

-- SELECT * FROM svc_region_allocations LIMIT 5;

-- SELECT * FROM cloud_costs ORDER BY svc_name, region

SELECT
  b.svc_name,
  b.region,
  s.cloud_spend AS actual_cost,
  b.budget AS budget,
  CASE
    WHEN b.budget > s.cloud_spend THEN 'over'
    WHEN b.budget < s.cloud_spend THEN 'under'
    WHEN b.budget = s.cloud_spend THEN 'on_target'
   END AS budget_flag
FROM svc_region_allocations AS b
JOIN cloud_spend AS s
  ON s.svc_name = b.svc_name
  AND s.region = b.region

*/

SELECT
  cc.svc_name,
  cc.region,
  cc.amount AS actual_cost,
  ca.amount AS budget,
  CASE
    WHEN cc.amount > ca.amount THEN 'over'
    WHEN cc.amount < ca.amount THEN 'under'
    ELSE 'on_target'
  END AS budget_flag
FROM cloud_costs AS cc
INNER JOIN cost_allocs AS ca
  ON cc.svc_name = ca.svc_name
  AND cc.region = ca.region
