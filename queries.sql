-- Average First Reply Time and Average First Resolution Time by Month for the Past 12 Months
SELECT
    TO_VARCHAR(DATE_TRUNC('month', t.created_at::date), 'mm-yyyy') as month_year,
    AVG(COALESCE(PARSE_JSON(m.reply_time_in_minutes):business::number, 0)) as avg_reply_time,
    AVG(COALESCE(PARSE_JSON(m.first_resolution_time_in_minutes):business::number, 0)) as avg_first_resolution_time
FROM
    HEVO_DATABASE.MONGO_MAIN_APP.ZD_TICKETS t
INNER JOIN
    HEVO_DATABASE.MONGO_MAIN_APP.ZD_TICKET_METRICS m ON t.id = m.ticket_id
WHERE
    t.created_at::date >= DATEADD(month, -12, current_date())
GROUP BY 1
ORDER BY 1;

-- Average Satisfaction Score and Total Tickets Solved by Agent by Month for the Last 6 Months
SELECT
    TO_VARCHAR(DATE_TRUNC('month', t.created_at::date), 'mm-yyyy') as year_month,
    u.name as agent_name,
    AVG(CASE
        WHEN PARSE_JSON(t.satisfaction_rating):score::STRING = 'good' THEN 1
        WHEN PARSE_JSON(t.satisfaction_rating):score::STRING = 'bad' THEN 0
        ELSE NULL
    END) * 100 as csat_score,
    COUNT(*) as total_tickets_solved
FROM
    HEVO_DATABASE.MONGO_MAIN_APP.ZD_TICKETS t
LEFT JOIN
    HEVO_DATABASE.MONGO_MAIN_APP.ZD_USERS u ON t.assignee_id = u.id
WHERE 
    t.status = 'solved' AND
    t.created_at::date >= DATEADD(month, -6, current_date())
GROUP BY 1, 2
ORDER BY 1;
