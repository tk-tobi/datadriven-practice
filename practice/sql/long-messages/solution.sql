SELECT
  author,
  message,
  LENGTH(message) AS message_length
FROM repo_commits
WHERE LENGTH(message) > 10 AND (LENGTH(message) > 0 OR message IS NULL);
