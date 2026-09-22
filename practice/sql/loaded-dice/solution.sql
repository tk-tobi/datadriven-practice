WITH
rollout_probability AS (
  SELECT
    flag_id,
    flag_name,
    rollout,
    created,
    (rollout*1.0/SUM(rollout) OVER ()) AS probability
  FROM feat_flags
)
  
SELECT
  flag_id,
  flag_name,
  rollout,
  IFNULL(probability, 0),
  IFNULL(SUM(probability) OVER (
    ORDER BY COALESCE(rollout, 0), flag_id
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 0)
    AS cummulative_prob
FROM rollout_probability

-- SELECT * FROM feat_flags ORDER BY created DESC;
