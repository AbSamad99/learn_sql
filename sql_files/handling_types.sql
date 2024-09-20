/*
 NOTE: You can use the `select` key outside of querying from a table as we are doing below
 */
-- Casting the string below to a date
select '2024-08-26'::date;
-- You can also perform conversions to various other data types as seen below
select '123'::integer,
    'true'::boolean,
    '3.14'::real;
/*
 Now performing similar operations on our data
 */
-- Changing job_posted_date from timestamp to just date
select job_title_short as title,
    job_location as location,
    job_posted_date::date as posted_date
from job_postings_fact
limit 10;
-- 
-- 
-- 
-- Changing job_posted_date from timestamp to just timestamp with timezone
-- Note that we do not have timezone information in the original column, which is why
-- we are converting it first to UTC and then again to EST (confusing I know).
select job_title_short as title,
    job_location as location,
    job_posted_date at time zone 'UTC' at time zone 'EST' as posted_date
from job_postings_fact
limit 10;
-- 
-- 
-- 
-- Extract day, month and year  from the timezone column
select job_title_short as title,
    job_location as location,
    extract(
        day
        from job_posted_date
    ) as posted_day,
    extract(
        month
        from job_posted_date
    ) as posted_month,
    extract(
        year
        from job_posted_date
    ) as posted_year
from job_postings_fact
limit 10;
-- 
-- 
-- 
-- Performing aggregation based on extracted month value
select count(job_id),
    extract(
        month
        from job_posted_date
    ) as month
from job_postings_fact
group by month
order by month;