
WITH ranked_content AS (
  SELECT
    c.content_type,
    DENSE_RANK() OVER (
      ORDER BY COUNT(*) DESC ) AS ranking
  FROM content_items AS c
  INNER JOIN users AS u
    ON c.creator_id = u.user_id
  GROUP BY c.content_type
)

SELECT
  c.content_id,
  c.title,
  c.content_type,
  c.duration_seconds,
  c.creator_id,
  c.publish_date
FROM content_items AS c
WHERE c.content_type IN (SELECT content_type FROM ranked_content WHERE ranking = 2);
 

-- SELECT * FROM users LIMIT 5;
