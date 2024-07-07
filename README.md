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
