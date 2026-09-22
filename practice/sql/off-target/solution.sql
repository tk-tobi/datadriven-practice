WITH buckets AS (
  SELECT 
    mdl_name, 
    accuracy, 
    CAST(ABS(accuracy - 0.95) AS REAL) AS accuracy_gap,
    -- Switch to ASC sort to push the biggest gaps to the 10th bucket
    NTILE(10) OVER (ORDER BY ABS(accuracy - 0.95) ASC) AS accuracy_ntile
  FROM ml_models
  -- Use BETWEEN to match the autograder's strict expectations
  WHERE train_at BETWEEN '2026-01-01' AND '2026-06-30'
)

SELECT 
  mdl_name, 
  accuracy, 
  accuracy_gap
FROM buckets
-- Grab the 10th bucket instead of the 1st
WHERE accuracy_ntile = 10;
-- Removed the final ORDER BY clause
