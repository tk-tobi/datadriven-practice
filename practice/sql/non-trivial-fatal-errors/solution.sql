-- SELECT * FROM err_tracks LIMIT 5;
SELECT
  err_id,
  message,
  svc_name,
  CASE
    WHEN LENGTH(message) BETWEEN 30 AND 31 THEN 'mid'
    WHEN LENGTH(message) >= 32 THEN 'long'
    END AS length_category
FROM err_tracks
WHERE LENGTH(message) >= 30
AND severity IN ('fatal', 'Fatal')
