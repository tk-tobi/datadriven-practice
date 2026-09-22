-- -- -- SELECT * FROM event_data
-- WITH crash_stats AS (
-- SELECT
--   event_timestamp, tags,
--   COUNT(*) FILTER (WHERE event_type = 'open') AS num_opens,
--   COUNT(*) FILTER (WHERE event_type = 'crash') AS num_crashes
-- FROM event_data
-- WHERE event_type in ('open', 'crash')
-- GROUP BY event_timestamp, tags
-- )

-- SELECT
--   *,
--   ROUND(num_crashes * 1.0 / num_opens, 4) AS crash_rate
-- FROM crash_stats
-- -- SELECT * FROM crash_stats

SELECT
    event_timestamp,
    tags,
    COUNT(*) FILTER (WHERE event_type = 'open') AS num_opens,
    COUNT(*) FILTER (WHERE event_type = 'crash') AS num_crashes,
    ROUND(
        COUNT(*) FILTER (WHERE event_type = 'crash') * 1.0 
        / COUNT(*) FILTER (WHERE event_type = 'open'), 
    4) AS crash_rate
FROM event_data
WHERE event_type IN ('open', 'crash')
GROUP BY 
    event_timestamp, 
    tags;
