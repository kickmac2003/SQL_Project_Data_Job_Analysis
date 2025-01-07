/* Write a query that lists all job postings with their job_id, salary_year_avg, and two additional columns using CASE WHEN statements called: experience_level and remote_option. Use the job_postings_fact table.
 
 For experience_level, categorize jobs based on keywords found in their titles (job_title) as 'Senior', 'Lead/Manager', 'Junior/Entry', or 'Not Specified'. Assume that certain keywords in job titles (like "Senior", "Manager", "Lead", "Junior", or "Entry") can indicate the level of experience required. ILIKE should be used in place of LIKE for this.
 NOTE: Use ILIKE in place of how you would normally use LIKE ; ILIKE is a command in SQL, specifically used in PostgreSQL. It performs a case-insensitive search, similar to the LIKE command but without sensitivity to case.
 For remote_option, specify whether a job offers a remote option as either 'Yes' or 'No', based on job_work_from_home column.
 🔎 Hint:
 
 Use CASE WHEN to categorize data based on conditions.
 Look for specific words that indicate job levels, like "Senior", "Manager", "Lead", "Junior", or "Entry". Use ILIKE to ensure the search for keywords is not case-sensitive.
 For the remote work option based on job_work_from_home column and look at the boolean value in this column.*/
SELECT job_id,
    salary_year_avg,
    CASE
        WHEN job_title ILIKE '%Senior%' THEN 'Senior'
        WHEN job_title ILIKE '%Manager%'
        OR job_title ILIKE '%Lead%' THEN 'Lead/Manager'
        WHEN job_title ILIKE '%Junior%'
        OR job_title ILIKE '%Entry%' THEN 'Junior/Entry'
        ELSE 'Not Specified'
    END AS experience_level,
    CASE
        WHEN job_work_from_home THEN 'Yes'
        ELSE 'No'
    END AS remote_option
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY job_id;
-- Subqueries examples
-- Example 1
SELECT *
FROM (
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(
                MONTH
                FROM job_posted_date
            ) = 1
    ) AS january_jobs;
-- Example 2
SELECT company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention
    );
-- CTEs (Common Table Expressions) Examples.
WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(
            MONTH
            FROM job_posted_date
        ) = 1
)
SELECT *
FROM january_jobs;
--Example 2
WITH company_job_count AS (
    SELECT company_id,
        COUNT(*) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT company_dim.name AS company_name,
    company_job_count.job_count
FROM company_dim
    LEFT JOIN company_job_count ON company_dim.company_id = company_job_count.company_id
ORDER BY job_count Desc;