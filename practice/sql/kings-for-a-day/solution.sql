-- SELECT * FROM batch_jobs;
WITH job_counter AS (
  SELECT
    SUBSTRING(started, 1, 10) AS job_date,
    job_name,
    rows_done,
    RANK() OVER (PARTITION BY SUBSTRING(started, 1, 10) ORDER BY rows_done DESC) AS rnk
    -- SUM(rows_done) OVER (PARTITION BY SUBSTRING(started, 1, 10)) AS rows_done
  FROM batch_jobs
)



SELECT
  job_date,
  job_name,
  rows_done
FROM job_counter
WHERE rnk = 1
