-- SELECT * FROM ml_models LIMIT 5;
SELECT 
  mdl_name,
  COUNT(*) AS run_count
FROM ml_models
-- WHERE status = 'training'
GROUP BY mdl_name
ORDER BY run_count DESC;
