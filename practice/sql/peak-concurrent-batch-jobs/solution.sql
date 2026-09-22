with flat_timeline AS (
  SELECT job_id, status, started AS event_timestamp, +1 AS event_type
  FROM batch_jobs
  WHERE status = 'running'
  UNION ALL
  SELECT job_id, status, ended AS event_timestamp, -1 AS event_type
  FROM batch_jobs
  WHERE status = 'running'
), concurrent_jobs AS (
  SELECT
    job_id,
    event_timestamp,
    SUM(event_type) OVER (ORDER BY event_timestamp ASC, event_type ASC) AS concurrent_count
  FROM flat_timeline
)

SELECT MAX(concurrent_count) FROM concurrent_jobs;

/* Checks */
-- SELECT COUNT(*) FROM batch_jobs;
-- SELECT DISTINCT(status) FROM batch_jobs;
-- SELECT COUNT(*) FROM flat_timeline;
-- SELECT COUNT(*) FROM batch_jobs WHERE status = 'running';
-- SELECT * FROM flat_timeline ORDER BY event_timestamp DESC;
-- SELECT * FROM concurrent_jobs ORDER BY event_timestamp ASC;
