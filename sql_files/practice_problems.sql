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
-- 
-- 
-- 
-- 
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
-- 
-- 
-- 
-- 
/*
 Write a query to find companies which have posted job offers with health insurance
 in the second quarter of 2023. Make use of date extraction
 */
select distinct
	cd."name" as company_name
from company_dim as cd
join job_postings_fact as jpf
	on cd.company_id = jpf.company_id
where 
	extract(
		month
		from jpf.job_posted_date
	) between 4 and 6
	and jpf.job_health_insurance is true
-- 
-- 
-- 
-- 
/*
 From the job_postings_fact table, create a new table which contains the jobs
 which were posted in january and february (separate tables)
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
create table feb_job_postings_fact as
select *
from job_postings_fact
where extract(
        year
        from job_posted_date
    ) = 2023
    and extract(
        month
        from job_posted_date
    ) = 2;
-- 
-- 
-- 
--
/*
 Identify top 5 skills that are most frequently used in job postings. 
 Use subquery to do this.
 */
select *
from skills_dim
where skill_id in (
        -- Sub query to find the most asked skill_id
        select skill_id
        from skills_job_dim
        group by skill_id
        order by count(*) desc
        limit 5
    );
/*
Using Join
*/
select sd.skills, count(sjd.job_id) as job_count
from skills_dim as sd
join skills_job_dim as sjd on sjd.skill_id = sd.skill_id
group by sd.skills
order by job_count desc
limit 5;
-- 
-- 
-- 
--
/*
 Determine the size of a company based on the amount of job posting they have:
 1. Small: count < 10
 2. Medium: 10 < count < 50
 3. Large: count > 50
 We will have to make use of CTE
 */
with company_job_count as (
    select company_id,
        count(*) as job_count
    from job_postings_fact
    group by company_id
)
select cd.*,
    cjc.job_count,
    case
        when cjc.job_count < 10 then 'Small'
        when cjc.job_count between 10 and 50 then 'Medium'
        when cjc.job_count > 50 then 'Large'
        else 'Small'
    end as company_size
from company_dim as cd
    join company_job_count as cjc on cd.company_id = cjc.company_id;
-- 
-- 
-- 
--
/*
 Find the number of remote job postings per skill
 - Display the 5 top skills by their demand
 - Include skill_id, name and count of postings where skill is needed
 */
with remote_job_skill as (
    select skill_id,
        count(*) as job_count
    from skills_job_dim
    where job_id in (
            select job_id
            from job_postings_fact
            where job_location = 'Anywhere'
        )
    group by skill_id
    order by job_count desc
    limit 5
)
select sd.*,
    rjs.job_count
from skills_dim as sd
    inner join remote_job_skill as rjs on sd.skill_id = rjs.skill_id;
/*
 Another way to do this is by using inner join as shown below
 */
with remote_job_skill as (
    select sjd.skill_id,
        count (*) as job_count
    from skills_job_dim as sjd
        inner join job_postings_fact as jpf on sjd.job_id = jpf.job_id
    where jpf.job_location = 'Anywhere'
    group by sjd.skill_id
    order by job_count desc
    limit 5
)
select sd.*,
    rjs.job_count
from skills_dim as sd
    inner join remote_job_skill as rjs on sd.skill_id = rjs.skill_id;
/*
 Another way
 */
select 
	skdim.skills,
	count(jobpost.job_id) as remote_job_count
from skills_dim as skdim
join skills_job_dim as skjob
	on skdim.skill_id = skjob.skill_id
join job_postings_fact as jobpost
	on skjob.job_id = jobpost.job_id
where jobpost.job_location = 'Anywhere'
group by skdim.skills
order by remote_job_count desc
limit 5;