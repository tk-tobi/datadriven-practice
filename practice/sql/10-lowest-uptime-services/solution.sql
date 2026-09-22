WITH ranked_svc AS (
  SELECT
    svc_name,
    min_uptime,
    DENSE_RANK() OVER (ORDER BY min_uptime ASC) AS rnking
  FROM (
    SELECT
      svc_name,
      MIN(uptime) AS min_uptime
    FROM svc_health
    GROUP BY svc_name ) sub_table
)
  
SELECT
  svc_name,
  min_uptime
FROM ranked_svc
WHERE rnking < 11;
  
