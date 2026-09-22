--/*
SELECT
  tbl_name,
  AVG(fail_pct) AS avg_fail_pct
FROM dq_checks
GROUP BY tbl_name
HAVING COUNT(*) > 1;

--*/
/* Checks */
-- SELECT * FROM dq_checks LIMIT 10;
