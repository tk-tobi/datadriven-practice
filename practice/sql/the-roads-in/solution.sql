/*
referrer
WHERE page_url LIKE %/blog
OR
WHERE page_url = /blog
*/

SELECT
  DISTINCT referrer
FROM page_views
WHERE page_url LIKE '%/blog%'
-- LIMIT 5;
