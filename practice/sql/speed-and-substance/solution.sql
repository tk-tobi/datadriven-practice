-- SELECT * FROM data_pipes LIMIT 10;
WITH per_pipeline AS (
SELECT
  pipe_name,
  AVG(dur_secs) AS avg_run_duration,
  AVG(rows_out - (0.1 * rows_in)) AS avg_net_row_output
FROM data_pipes
WHERE dur_secs IS NOT NULL
AND rows_in IS NOT NULL
AND rows_out IS NOT NULL
GROUP BY pipe_name
)
SELECT 
  ROUND(
    (AVG(avg_run_duration * avg_net_row_output) - AVG(avg_run_duration) * AVG(avg_net_row_output)) / 
    SQRT((AVG(avg_run_duration * avg_run_duration) - AVG(avg_run_duration) * AVG(avg_run_duration)) * (AVG(avg_net_row_output * avg_net_row_output) - AVG(avg_net_row_output) * AVG(avg_net_row_output))),
    2
  ) AS correlation
FROM per_pipeline;
