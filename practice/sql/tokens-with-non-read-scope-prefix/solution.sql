
-- SELECT
--   COUNT(DISTINCT owner_id) AS non_read_owner_account
-- FROM (
--   SELECT
--     owner_id,
--     FIRST_VALUE(status) OVER (PARTITION BY owner_id ORDER BY issued) AS first_scope
--   FROM api_tokens
-- ) sub_table
-- WHERE first_scope NOT LIKE 'read%';

SELECT
  COUNT(DISTINCT owner_id) AS non_read_owner_count
FROM api_tokens
WHERE scope NOT LIKE 'read%';
