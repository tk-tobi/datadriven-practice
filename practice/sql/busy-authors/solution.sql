SELECT
  LOWER(author),
  COUNT(DISTINCT repo_name) AS repo_count
FROM repo_commits
GROUP BY LOWER(author)
HAVING repo_count > 1;
