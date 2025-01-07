-- Union and Union All Excercise

(
    SELECT
    job_id,
    job_title,
    'With Salary info' AS salary_info
FROM job_postings_fact
WHERE
    salary_year_avg IS Not NULL OR salary_hour_avg IS NOT NULL
)

UNION All

(
    SELECT
        job_id,
        job_title,
        'Without Salary Info' AS salary_info
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NULL OR salary_hour_avg IS NULL
) 
    ORDER BY job_id;


SELECT
     merged.job_id, 
     merged.job_title_short, 
     merged.job_location, 
     merged.job_via, 
     skills_dim.skills, 
     skills_dim.type
FROM(
    
(SELECT *
FROM january_jobs)
UNION All
(SELECT *
FROM february_jobs)
UNION All
(SELECT *
FROM march_jobs) ) AS merged
LEFT JOIN
skills_job_dim ON merged.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    merged.salary_year_avg > 70000
ORDER BY
	merged.job_id;

SELECT skills_dim.skills,
        COUNT(merged.job_id) AS job_count,
        EXTRACT(MONTH FROM merged.job_posted_date) AS posted_month
    FROM(

(SELECT *
FROM january_jobs)
UNION All
(SELECT *
FROM february_jobs)
UNION All
(SELECT *
FROM march_jobs)) AS merged
LEFT JOIN skills_job_dim ON merged.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills, EXTRACT(MONTH FROM merged.job_posted_date)
ORDER BY posted_month DESC;


