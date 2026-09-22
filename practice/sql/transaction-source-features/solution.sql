SELECT
  DISTINCT feat_name
FROM ml_features
WHERE avg_val IS NOT NULL
AND source = 'transactions'
