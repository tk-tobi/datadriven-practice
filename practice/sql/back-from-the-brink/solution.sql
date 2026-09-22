/*
grain: deploy_log

input -> 'status' , 'deplot_at'

LOWER(author)
LOWER(status)

WHERE <bounce back after a roll back>
WHERE LAG(status) == success AND status == failed

COUNT(DISTINCT)

CTE:
  - LEAD(status) OVER (PARTITION BY LOWER(author))
*/
-- SELECT * FROM deploy_logs LIMIT 5;
WITH log_next_and_current AS (
  SELECT
    LOWER(author) AS author,
    LOWER(status) AS status,
    LEAD(LOWER(status)) OVER (PARTITION BY LOWER(author) ORDER BY deploy_at) AS next_status
  FROM deploy_logs
)

SELECT
  COUNT(DISTINCT author) AS recovery_count
FROM log_next_and_current
WHERE status = 'rolled_back' AND next_status = 'success';
