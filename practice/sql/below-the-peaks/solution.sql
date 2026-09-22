-- WITH spend_ranking AS (
-- SELECT
--   *,
--   AVG(amount) OVER (PARTITION BY team_name) AS team_avg,
--   RANK() OVER (PARTITION BY team_name ORDER BY amount DESC) AS spend_rnk
-- FROM cost_allocs
-- )

-- SELECT
--   team_name,
--   amount
-- FROM spend_ranking
-- WHERE amount > team_avg
-- AND spend_rnk > 5

WITH team_avg AS (
  SELECT
    team_name,
    AVG(amount) AS avg_amount
  FROM cost_allocs
  GROUP BY team_name
),
ranked AS (
  SELECT
    ca.team_name,
    ca.amount,
    ROW_NUMBER() OVER (
      PARTITION BY ca.team_name
      ORDER BY ca.amount DESC
    ) AS rn
  FROM cost_allocs AS ca
)
SELECT
  r.team_name,
  r.amount
FROM ranked AS r
INNER JOIN team_avg AS ta
  ON r.team_name = ta.team_name
WHERE r.amount > ta.avg_amount
AND r.rn > 5
