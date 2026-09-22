SELECT
  trigger AS author,
  branch,
  COUNT(*) AS build_count
FROM ci_builds
GROUP BY trigger, branch
ORDER BY build_count
-- SELECT * FROM ci_builds LIMIT 5;
