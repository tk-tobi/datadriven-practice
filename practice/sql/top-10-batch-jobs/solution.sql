SELECT
  job_name,
  rnk
FROM (
  SELECT
    job_name,
    DENSE_RANK() OVER (ORDER BY SUM(rows_done) DESC) rnk
  FROM batch_jobs
  GROUP BY job_name
) sub_table
WHERE rnk <= 10
ORDER BY rnk, job_name

-- SELECT * FROM batch_jobs ORDER BY rows_done DESC LIMIT 5;
