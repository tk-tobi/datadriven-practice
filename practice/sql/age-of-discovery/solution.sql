-- SELECT * FROM search_queries;
-- SELECT * FROM users;
SELECT
  u.age_bucket,
  COUNT(*) AS total_searches,
  COUNT(*) FILTER (WHERE clicked_result IS NOT NULL) AS successful_searches,
  COUNT(*) FILTER (WHERE clicked_result IS NOT NULL) * 1.0 /
    COUNT(*) AS success_rate
FROM search_queries AS s
JOIN users AS u
  ON s.user_id = u.user_id
WHERE u.age_bucket IS NOT NULL
GROUP BY u.age_bucket
