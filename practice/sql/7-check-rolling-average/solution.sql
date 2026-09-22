SELECT
  svc_name,
  checked,
  latency,
  AVG(latency) OVER (
    PARTITION BY svc_name
    ORDER BY checked
    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_avg
 from svc_health;
