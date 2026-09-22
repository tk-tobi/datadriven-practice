/*WITH edge_hit_pct AS (
  SELECT
    edge_loc,
    COUNT(*) AS request_count,
    COUNT(CASE WHEN cache_hit = 1 THEN 1 ELSE NULL END) AS hit_count
  FROM cdn_logs
  GROUP BY edge_loc
), global_hit_count AS (
  SELECT
    SUM(hit_count)*1.0/SUM(request_count) * 100
  FROM edge_hit_pct
  )


SELECT
  edge_loc,
  request_count,
  ROUND((hit_count*1.0/request_count)*100, 2) AS hit_pct,
  (SELECT * FROM global_hit_count) AS overall_hit_pct
FROM edge_hit_pct
ORDER BY hit_pct DESC;

*/


SELECT
  edge_loc,
  COUNT(*) AS request_count,
  ROUND(SUM(cache_hit) * 100.0 / COUNT(*), 2) AS hit_pct,
  SUM(SUM(cache_hit)) OVER () * 100 / SUM(COUNT(*)) OVER () AS overall_hit_pct
FROM cdn_logs
GROUP BY edge_loc
ORDER BY hit_pct DESC;
