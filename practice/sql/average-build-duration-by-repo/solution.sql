/*
AVG(dur_secs)
GROUP BY repo_name
*/

SELECT
  repo_name,
  AVG(dur_secs)
FROM ci_builds
GROUP BY repo_name
