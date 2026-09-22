WITH prev_status AS (
SELECT
  svc_name,
  checked,
  LAG(status) OVER (PARTITION BY svc_name ORDER BY checked) AS previous_status,
  status AS current_status
FROM svc_health )
-- WHERE status <> LAG(status) OVER (PARTITION BY svc_name ORDER BY checked)

SELECT * 
FROM prev_status 
WHERE previous_status IS NOT NULL
AND current_status <> previous_status;
