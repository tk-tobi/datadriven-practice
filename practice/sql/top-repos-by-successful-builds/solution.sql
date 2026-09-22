SELECT
  repo_name,
  COUNT(*) AS success_count
FROM ci_builds
WHERE LOWER(status) = 'success'
GROUP BY repo_name
ORDER BY 2 DESC
