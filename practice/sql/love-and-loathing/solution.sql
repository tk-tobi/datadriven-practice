-- SELECT COUNT(*) FROM feat_flags WHERE enabled = 1 ORDER BY rollout DESC

WITH supporters AS (
SELECT
  owner,
  ROW_NUMBER() OVER (ORDER BY rollout DESC, flag_id) AS rnk
FROM feat_flags
WHERE enabled = 1
), 
detractors AS (
SELECT
  owner,
  ROW_NUMBER() OVER (ORDER BY rollout, flag_id) AS rnk
FROM feat_flags
WHERE enabled = 0
)
SELECT
  s.owner AS fan_owner,
  d.owner AS opponent_owner
FROM supporters AS s
LEFT JOIN detractors AS d
  ON s.rnk = d.rnk
