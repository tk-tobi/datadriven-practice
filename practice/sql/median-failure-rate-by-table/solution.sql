WITH pre_median_ranking AS (
  SELECT
    tbl_name,
    COUNT(fail_pct) OVER (PARTITION BY tbl_name) AS tbl_count,
    ROW_NUMBER() OVER (PARTITION BY tbl_name ORDER BY fail_pct) AS tbl_rnk,
    fail_pct
  FROM dq_checks
  WHERE fail_pct IS NOT NULL
)

SELECT
  tbl_name,
  AVG(fail_pct) AS median_fail_pct
FROM pre_median_ranking
WHERE tbl_rnk IN ((tbl_count + 1) / 2, (tbl_count + 2) / 2)
GROUP BY tbl_name
ORDER BY 2 DESC
