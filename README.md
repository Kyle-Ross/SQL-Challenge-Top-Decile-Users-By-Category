# SQL Challenge: Top Decile Users By Category

I made this query as a solution to a Data Analyst interview challenge for a role at a large Australian tech company. I ended up accepting a different role, but it was a great challenge and a good example of my SQL skills. I was able to successfully employ CTEs, Window Functions, Timestamps, Joins and create deciles by groupings.

## The Challenge

### Scenario
One of our growth marketers would like to have a message conditionally inserted into a regular bulk email. The idea is to include a premium subscription upgrade CTA at the top of an email subject to the following criteria:
•	Out of the users who have exported a design in the previous 7 days, the user is in the top decile by number of exports in that period.
The marketer also wants to use the category (birthday invitation, business card, etc) of the design that the user last exported.
The email marketer needs your help to identify the users in that top decile and the category of the last exported design.

### Task
For an event table (called design_exported ) containing the following columns, write an SQL query to determine the decile (1 is the lowest, 10 the highest) of each user by event count and the category of the user’s last exported design.
-	event_id
    -	unique identifier of each event (duplicates rows may exist in design_exported )
-	timestamp
    -	unix epoch time of the event (seconds)
-	user_id
-	design_category
    -	English-language text label for the category of the exported design
    -	example values: ‘birthday invitation’, ‘business card’, ‘festival poster’

Please ensure that your SQL is roughly compatible with a PostgreSQL 9.5 database. We don't mind if there are minor syntax issues so you shouldn't need to install the database to test your query.

### My Solution

Includes inline comments explaining the sections of the query.

[![top decile sql challenge](https://img.shields.io/badge/PostgreSQL_Query-31648c?style=for-the-badge&logo=PostgreSQL&logoColor=white)](https://github.com/Kyle-Ross/SQL-Challenge-Top-Decile-Users-By-Category/blob/9c2ba06c873c425c039cdb34fbf7947853784838/top_decile_users_by_category.sql)

This was tested on sample data which I created.

[![Sample Data](https://img.shields.io/badge/Sample_Data-217346?style=for-the-badge&logo=microsoftexcel&logoColor=white)](https://github.com/Kyle-Ross/SQL-Challenge-Top-Decile-Users-By-Category/blob/515c51219fa74045245c0b639c01b37f05179cf8/Sample%20Data.csv)
