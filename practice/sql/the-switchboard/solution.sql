WITH last_feat_flag AS (
  SELECT
    flag_name,
    enabled,
    ROW_NUMBER() OVER (PARTITION BY flag_name ORDER BY updated DESC) AS rnk
  FROM feat_flags
)
SELECT
  flag_name,
  enabled AS enabled_flag,
  CASE
    WHEN enabled = 1 THEN 0
    ELSE 1
    END AS disabled_flag
FROM last_feat_flag WHERE rnk = 1
