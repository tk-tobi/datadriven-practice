    
WITH combined_table AS (
  SELECT
    svc_name,
    region,
    amount,
    acct_id
  FROM cloud_costs
  UNION ALL
  SELECT
    svc_name,
    region,
    amount,
    acct_id
  FROM cost_allocs
), extremes_cte AS (
  SELECT
    region,
    svc_name,
    amount,
    max_row_num,
    min_row_num
  FROM ( SELECT
      *,
      ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount DESC, svc_name) AS max_row_num,
      ROW_NUMBER() OVER (PARTITION BY region ORDER BY amount, svc_name) AS min_row_num
    FROM combined_table) sub_table
  WHERE max_row_num = 1 OR min_row_num = 1
)
  
SELECT
  region,
  MAX(CASE WHEN max_row_num = 1 THEN svc_name END) AS most_expensive,
  MAX(CASE WHEN min_row_num = 1 THEN svc_name END) AS cheapest
FROM extremes_cte
GROUP BY region;

/*
SELECT
  c.region AS region,
  e.svc_name AS most_expensive,
  c.svc_name AS cheapest
FROM cheapest_cte AS c
JOIN most_expensive_cte AS e
  ON c.region = e.region
*/
