SELECT
  region,
  COUNT(*) AS node_count
FROM infra_nodes
WHERE LOWER(status) = 'running'
GROUP BY region
HAVING COUNT(*) > 5;
-- SELECT * FROM infra_nodes;
