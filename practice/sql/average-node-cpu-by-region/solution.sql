/*
-- Gemini Suggested
SELECT 
    n.region,
    ROUND(AVG(n.cpu_pct), 3) AS avg_cpu
FROM infra_nodes AS n
WHERE EXISTS (
    SELECT 1 
    FROM pod_assignments AS p 
    WHERE p.node_id = n.node_id
)
GROUP BY n.region
ORDER BY avg_cpu DESC;
*/

--/*
SELECT
  i.region,
  ROUND(AVG(i.cpu_pct), 3) AS avg_cpu
FROM infra_nodes AS i
GROUP BY i.region
HAVING COUNT(*) >= 1;
--*/
-- Exploratory --
-- SELECT DISTINCT status FROM pod_assignments LIMIT 5;
-- SELECT DISTINCT status FROM infra_nodes LIMIT 10;
