/*
Questions this query addresses:
1. What are the top 10 highest-paying 'Data Analyst' job postings in New York, United States?
2. What are the key details of these jobs, such as job location, schedule type, and posting date?
*/

SELECT
    job_id,
    job_title,
    salary_year_avg,
    company_dim.name AS company_name,
    job_schedule_type,
    job_location,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    job_location LIKE '%New York%' AND
    salary_year_avg 
    IS NOT NULL
ORDER BY
    salary_year_avg DESC
    LIMIT 10;
