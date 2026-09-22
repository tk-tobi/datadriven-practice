--/*
SELECT
  job_id,
  job_name,
  CAST(TIMESTAMPDIFF(MINUTE, CAST(started AS TIMESTAMP), CAST(ended AS TIMESTAMP))*1440 AS INT) AS minutes_elapsed
FROM batch_jobs
WHERE ended > started;
--*/

--SELECT * FROM batch_jobs LIMIT 5;
