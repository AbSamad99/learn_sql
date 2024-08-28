/*
 Making use of case expression to define a new column in the table based on job location:
 1. If 'Anywhere' set as 'Remote'
 2. If 'New York, NY' mark as 'Local'
 3. Otherwise, mark as 'Onsite'
 */
select job_id,
    job_title_short,
    job_location,
    case
        when job_location = 'Anywhere' then 'Remote'
        when job_location = 'New York, NY' then 'Local'
        else 'Onsite'
    end as job_kind
from job_postings_fact
limit 10;
-- It can also be written as follows, this is called 'simple case expression' form.
select job_id,
    job_title_short,
    job_location,
    case
        job_location
        when 'Anywhere' then 'Remote'
        when 'New York, NY' then 'Local'
        else 'Onsite'
    end as job_kind
from job_postings_fact
limit 10;
-- 
-- 
-- 
-- 
/*
 Using a subquery, which is a query within a query. The subquery is always run first and then the parent query
 is run. In this example, we are finding all the companies which have posted jobs with no degree requirement.
 1. First find the jobs which require no degree
 2. Wrap it with a parent query
 */
select *
from company_dim
where company_id in (
        -- The subquery
        select company_id
        from job_postings_fact
        where job_no_degree_mention = true
    )
order by company_id;
/*
 If you do the same with a join, it will give you a lot of duplicate values as seen
 when you run the query below
 */
select *
from company_dim as cd
    inner join job_postings_fact as jpf on cd.company_id = jpf.company_id
where jpf.job_no_degree_mention = true
order by cd.company_id;
-- 
-- 
-- 
--
/*
 Common Table Expression: Returns a temporary result set which you can use in select, insert, update and 
 delete statements. It exists only until the execution of the query, so you can't execute one query and access
 the result set in a subsequent query. It is also known as named query. It has to be defined using the 
 `with` statement.
 In the example below we are trying to find the companies with the most number of job openings
 */
--  Defining the CTE
with company_job_count as (
    select company_id,
        count(job_id) as total_jobs
    from job_postings_fact
    group by company_id
)
/* 
 Verifying that the CTE was created 
 -- select *
 -- from company_job_count
 */
/* 
 Joining company_dim table with the temporary set to obtain the company name. The reason for keeping company_dim
 on the left is because we may have companies with 0 job postings.
 */
select cd.company_id,
    cd.name,
    cjc.total_jobs
from company_dim as cd
    left join company_job_count as cjc on cd.company_id = cjc.company_id
order by cjc.total_jobs;
-- 
-- 
-- 
-- 
/*
 Union Operation: Kind of opposite to how join works, it adds rows rather than columns.
 You can use this to join two sets of rows provided they have the SAME COLUMNS.
 By default just specifying `union` as done below will combine the rows and remove
 the duplicates. If you want to return all rows including duplicates use `union all`.
 */
select job_title_short,
    company_id,
    job_location
from jan_job_postings_fact
union
select job_title_short,
    company_id,
    job_location
from feb_job_postings_fact;
-- Combining union with subquery
select jan_feb_postings.job_title_short,
    jan_feb_postings.job_location,
    jan_feb_postings.salary_hour_avg
from (
        select *
        from jan_job_postings_fact
        union all
        select *
        from feb_job_postings_fact
    ) as jan_feb_postings
where jan_feb_postings.salary_year_avg > 70000
order by salary_hour_avg desc;