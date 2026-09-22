-- SELECT * FROM stream_msgs LIMIT 5;
WITH standard_ranking AS (
SELECT
  topic,
  offset,
  LAG(offset) OVER (PARTITION BY topic ORDER BY offset) AS prev_offset,
  DENSE_RANK() OVER (PARTITION BY topic ORDER BY offset) AS msg_rank,
  ROW_NUMBER() OVER (PARTITION BY topic ORDER BY offset) AS msg_row_num
FROM stream_msgs
)
SELECT * FROM standard_ranking WHERE prev_offset IS NOT NULL
