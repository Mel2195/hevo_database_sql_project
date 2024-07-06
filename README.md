# hevo_database_sql_project

## Tables

**`ZD_Tickets` Table:**
- **Key Fields:** `ID`, `CREATED_AT`, `UPDATED_AT`, `ASSIGNEE_ID`, `STATUS`, `SATISFACTION_RATING`
- **Description:** Contains comprehensive details about customer tickets.

**`ZD_Users` Table:**
- **Key Fields:** `ID`, `NAME`, `ROLE`
- **Description:** Details about users, including agents handling the tickets.

**`ZD_Ticket_Metrics` Table:**
- **Key Fields:** `TICKET_ID`, `REPLY_TIME_IN_MINUTES`, `FIRST_RESOLUTION_TIME_IN_MINUTES`
- **Description:** Tracks specific metrics related to each ticket, like reply times and resolution times.

## Queries

### Average First Reply Time and Average First Resolution Time by Month for the Past 12 Months
```sql
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
SQL queries and table definitions for analyzing ticket data from HEVO_DATABASE
