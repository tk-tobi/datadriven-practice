SELECT 
  job_name,
  rnk AS position
FROM (
  SELECT
    *,
    DENSE_RANK() OVER (ORDER BY rows_done DESC) AS rnk
  FROM batch_jobs) sub_table
WHERE rnk BETWEEN 8 AND 10
ORDER BY rnk DESC;
  
