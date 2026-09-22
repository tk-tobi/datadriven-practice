SELECT
  COUNT(DISTINCT mdl_name) AS training_count
FROM ml_models
WHERE LOWER(status) = 'training'
