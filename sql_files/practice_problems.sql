/*
 Write a query to find the average yearly and hourly salary for job postings 
 posted after June 1, 2023. Group the results by job schedule type
 */
select job_schedule_type,
    avg(salary_hour_avg) as hourly,
    avg(salary_year_avg) as yearly
from job_postings_fact
where job_posted_date::date > '2023-06-01'
group by job_schedule_type;
/*
 Write a query to count the number of job postings for each month of 2023, 
 adjusting the time zone to 'America/New_York' before extracting the month.
 Group and order by month
 */
select count (job_id),
    extract(
        month
        from (
                job_posted_date at time zone 'UTC' at time zone 'EDT'
            )
    ) as month
from job_postings_fact
group by month
order by month;
/*
 Write a query to find companies which have posted job offers with health insurance
 in the second quarter of 2023. Make use of date extraction
 */
select *
from job_postings_fact
where extract(
        month
        from job_posted_date
    ) between 5 and 8
    and extract(
        year
        from job_posted_date
    ) = 2023
    and job_health_insurance is true;
/*
 From the job_postings_fact table, create a new table which contains the jobs
 which were posted in january
 */
create table jan_job_postings_fact as
select *
from job_postings_fact
where extract(
        year
        from job_posted_date
    ) = 2023
    and extract(
        month
        from job_posted_date
    ) = 1;