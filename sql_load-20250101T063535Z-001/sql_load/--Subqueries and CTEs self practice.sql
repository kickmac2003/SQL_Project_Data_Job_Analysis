--Subqueries and CTEs self practice
--Example 1
SELECT job_id, job_title_short
FROM job_postings_fact
WHERE salary_year_avg > (SELECT AVG(salary_year_avg) FROM job_postings_fact);
--Explanation: The subquery calculates the average salary, and the main query retrieves jobs roles that pays more than that value

--Example 2
SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT company_id
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst'
);
/* Explanation: The subquery finds all companies that post Data Analyst role, 
and the main query retrieves names of those companies*/

WITH company_job_title AS (
    SELECT
        company_id,
        COUNT(DISTINCT job_title) AS unique_count
    FROM job_postings_fact
    GROUP BY company_id
)
    SELECT company_dim.name,
           company_job_title.unique_count
    FROM company_dim
    INNER JOIN company_job_title ON company_dim.company_id = company_job_title.company_id
    ORDER BY unique_count DESC
    LIMIT 10;



SELECT
name AS company_name,
COUNT(DISTINCT job_title) AS unique_titles
FROM company_dim
LEFT JOIN
job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
GROUP BY
company_name
ORDER BY
unique_titles DESC
LIMIT 10;


WITH job_postings AS (
    SELECT
        job_country,
        AVG(salary_year_avg) AS avg_salary
FROM job_postings_fact
    GROUP BY job_country       
)

    SELECT
        job_postings_fact.job_id,
        job_postings_fact.job_title,
        company_dim.name AS company_name,
        job_postings_fact.salary_year_avg,
CASE
    WHEN job_postings_fact.salary_year_avg > job_postings.avg_salary THEN 'Above Average'
    ELSE 'Below Average'
END AS salary_category,
EXTRACT (MONTH FROM job_postings_fact.job_posted_date) AS posted_month
FROM job_postings_fact
INNER JOIN job_postings ON job_postings_fact.job_country = job_postings.job_country
INNER JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
ORDER BY posted_month DESC;



WITH avg_salaries AS (
  SELECT 
    job_country, 
    AVG(salary_year_avg) AS avg_salary
  FROM job_postings_fact
  GROUP BY job_country
)

SELECT
  -- Gets basic job info
	job_postings.job_id,
  job_postings.job_title,
  companies.name AS company_name,
  job_postings.salary_year_avg AS salary_rate,
-- categorizes the salary as above or below average the average salary for the country
  CASE
    WHEN job_postings.salary_year_avg > avg_salaries.avg_salary
    THEN 'Above Average'
    ELSE 'Below Average'
  END AS salary_category,
  -- gets the month and year of the job posting date
  EXTRACT(MONTH FROM job_postings.job_posted_date) AS posting_month
FROM
  job_postings_fact as job_postings
INNER JOIN
  company_dim as companies ON job_postings.company_id = companies.company_id
INNER JOIN
  avg_salaries ON job_postings.job_country = avg_salaries.job_country
ORDER BY
    -- Sorts it by the most recent job postings
    posting_month desc;


WITH unique_skills AS(
    SELECT job_postings_fact.company_id,
    COUNT(DISTINCT skills_job_dim.skill_id) AS skill_count
    FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
     GROUP BY job_postings_fact.company_id),

 max_salary AS (
    SELECT company_id,
    MAX(salary_year_avg) AS most_salary
    FROM job_postings_fact
    WHERE job_id IN (SELECT job_id FROM skills_job_dim)
    GROUP BY company_id
)

    SELECT
        company_dim.name,
        unique_skills.skill_count,
        max_salary.most_salary
    FROM
        company_dim
LEFT JOIN unique_skills ON company_dim.company_id = unique_skills.company_id
LEFT JOIN max_salary ON company_dim.company_id = max_salary.company_id
    ORDER BY company_dim.name;














