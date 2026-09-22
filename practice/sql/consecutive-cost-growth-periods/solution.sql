WITH period_totals AS (
  SELECT
    bill_date,
    SUM(amount) AS period_total
  FROM cloud_costs
  WHERE acct_id IS NOT NULL
  GROUP BY bill_date
),
-- SELECT * FROM period_totals LIMIT 5;
overall_growth_num AS (
SELECT
  bill_date,
  period_total,
  ROW_NUMBER() OVER (ORDER BY bill_date) AS overall_rn,
  LAG(period_total) OVER (ORDER BY bill_date) AS prev_total
FROM period_totals),
increasing_growth_num AS (
SELECT
  bill_date,
  -- period_total,
  -- overall_rn,
  overall_rn - ROW_NUMBER() OVER (ORDER BY bill_date) AS group_key
FROM overall_growth_num
WHERE period_total > prev_total)

  SELECT 
    MIN(bill_date) AS start_date,
    COUNT(*) AS streak_len
  FROM increasing_growth_num
  GROUP BY group_key
  HAVING COUNT(*) >= 2;
