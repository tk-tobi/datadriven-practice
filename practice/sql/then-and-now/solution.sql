-- WITH accuracy_window_fn AS (
-- SELECT
--   mdl_name,
--   AVG(accuracy) OVER (PARTITION BY mdl_name)AS avg_accuracy,
--   FIRST_VALUE(accuracy) OVER (PARTITION BY mdl_name ORDER BY train_at DESC) AS latest_accuracy,
--   COUNT(*) OVER (PARTITION BY mdl_name) AS version_count,
--   SUM(accuracy) OVER (PARTITION BY mdl_name) AS total
-- FROM ml_models
-- WHERE accuracy IS NOT NULL
--   AND train_at IS NOT NULL
--   AND train_at <> ''
-- )

-- SELECT
--   DISTINCT mdl_name AS model_name,
--   ROUND(avg_accuracy, 2) AS avg_lifetime_accuracy,
--   ROUND(latest_accuracy, 2) AS latest_accuracy,
--   ROUND(latest_accuracy - (total - latest_accuracy)/(version_count - 1), 2) AS difference
-- FROM accuracy_window_fn
-- ORDER BY 1

WITH valid AS (
  SELECT
    mdl_name,
    accuracy,
    train_at,
    ROW_NUMBER() OVER (
      PARTITION BY mdl_name
      ORDER BY train_at DESC, model_id DESC
    ) AS rn,
    COUNT(*) OVER (
      PARTITION BY mdl_name
    ) AS n_versions
  FROM ml_models
  WHERE accuracy IS NOT NULL
  AND train_at IS NOT NULL
  AND train_at <> ''
),
agg AS (
  SELECT
    mdl_name,
    n_versions,
    MAX(
      CASE
        WHEN rn = 1 THEN accuracy
      END
      ) AS latest_accuracy,
    AVG(accuracy) AS avg_lifetime_accuracy,
    AVG(
      CASE
        WHEN rn > 1 THEN accuracy
      END
      ) AS avg_previous_accuracy
  FROM valid
  GROUP BY mdl_name, n_versions
)
SELECT
  mdl_name AS model_name,
  ROUND(
    avg_lifetime_accuracy,
    2
    ) AS avg_lifetime_accuracy,
  ROUND(latest_accuracy, 2) AS latest_accuracy,
  CASE
    WHEN n_versions = 1 THEN 0
    ELSE ROUND(
      latest_accuracy - avg_previous_accuracy,
      2
      )
  END AS difference
FROM agg
ORDER BY model_name
