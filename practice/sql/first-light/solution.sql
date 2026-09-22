
WITH filtered_ci_builds AS (
  SELECT
    repo_name,
    MIN(built_at) AS built_at,
    DATEADD(days, 365, DATE(MIN(built_at))) AS end_date
  FROM ci_builds
  GROUP BY repo_name
)
  
--SELECT * FROM filtered_ci_builds;
-- SELECT * FROM repo_commits ORDER BY repo_name, commit_at LIMIT 5;

SELECT
  rc.author,
  AVG(rc.added) AS avg_lines_added,
  AVG(JULIANDAY(rc.commit_at) - JULIANDAY(ci.built_at)) AS avg_days_after_first_build 
FROM repo_commits AS rc
JOIN filtered_ci_builds AS ci
  ON rc.repo_name = ci.repo_name
WHERE date(rc.commit_at) <= ci.end_date
GROUP BY rc.author;

/*
with repo_start as (
select distinct repo_name, 
min(built_at) start_date,
DATEADD(days, 365, date(min(built_at))) end_date
from ci_builds
group by repo_name
)
select author, avg(added) lines, 
avg(datediff(days, start_date, commit_at)) build
from repo_commits rc
join repo_start rs
on rs.repo_name = rc.repo_name and date(commit_at) <= end_date
group by author
*/
