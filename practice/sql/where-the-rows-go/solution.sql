SELECT
  pipe_name,
  start_at,
  ROUND(rows_out*1.0/rows_in, 4)AS throughput_ratio
FROM data_pipes
ORDER BY pipe_name, start_at
