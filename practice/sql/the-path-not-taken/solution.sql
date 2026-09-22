-- SELECT * FROM page_views LIMIT 20;

-- SELECT users that have visited the new editor
WITH first_visit AS (
SELECT
  user_id,
  viewed_at
FROM page_views
WHERE page_url = 'new_editor'
QUALIFY ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY viewed_at) = 1
)

SELECT
  f.user_id
FROM first_visit AS f
LEFT JOIN page_views AS p
  ON f.user_id = p.user_id
  AND p.page_url = 'classic_editor'
  AND p.viewed_at < f.viewed_at
WHERE p.user_id IS NULL


-- SELECT * FROM first_visit LIMIT 5;

-- Of this users, SELECT users w/ no old editor visit before new editor first viewed_at
