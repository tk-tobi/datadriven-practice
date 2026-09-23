SELECT DISTINCT
  start_at::date AS run_date
FROM data_pipes
WHERE start_at::date < '2026-05-01'
ORDER BY run_date;
