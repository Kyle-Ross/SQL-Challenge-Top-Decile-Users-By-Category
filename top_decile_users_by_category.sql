-- Written in PostgreSQL syntax

-- 'user_exports' CTE providing by user event counts,
-- limits to events within 7 days of timestamp at time of query
-- counts only distinct events to account for duplicates

WITH user_exports AS (
	SELECT
		user_id,
		COUNT(DISTINCT event_id) AS event_count,
		MAX(timestamp) AS recent_export_timestamp
	FROM design_exported
	WHERE timestamp > 
		(CAST(EXTRACT(epoch FROM NOW()) AS INT) - 604800) -- i.e. Current timestamp - 7 days
	GROUP BY user_id
	ORDER BY event_count DESC, user_id),

-- second CTE 'decile_output' providing most recent category
-- and decile ranking via window function
-- joins 'user_exports' with base table to get most recent category
	
decile_output AS
	(SELECT 
		user_exports.user_id AS user_id,
		user_exports.event_count AS event_count,
		user_exports.recent_export_timestamp AS recent_export_timestamp,
		FLOOR(
			CAST(
				PERCENT_RANK() OVER(ORDER BY event_count) 
				AS DECIMAL(4,2)
				) * 10
				) AS decile_rank,
		design_exported.design_category AS recent_export_cat 
	
	FROM user_exports
	
	LEFT JOIN design_exported ON
		(user_exports.user_id = design_exported.user_id 
		AND
		user_exports.recent_export_timestamp = design_exported.timestamp)
	ORDER BY decile_rank DESC)


-- Final statement which outputs the user id,
-- event count, decile, most recent export time and category
-- Per user, from events in the last 7 days
-- WHERE clause can easily be added to limit results to users over certain deciles 	
	
SELECT 
	user_id,
	event_count AS export_count,
	decile_rank,
	CONCAT(
		to_timestamp(recent_export_timestamp)::date,' ',
		to_timestamp(recent_export_timestamp)::time
		) AS most_recent_export_time,
	recent_export_cat AS most_recent_export_cat
FROM decile_output
ORDER BY decile_rank DESC;