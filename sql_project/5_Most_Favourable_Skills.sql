WITH required_skills AS(
    SELECT
        skills_dim.skill_id,
		skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM
    job_postings_fact
    INNER JOIN
	    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
	INNER JOIN
	    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location like '%New York%'
GROUP BY
    skills_dim.skill_id
),

paying_skills AS (
SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM
    job_postings_fact
	  INNER JOIN
	    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%New York%' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_job_dim.skill_id
)

SELECT
  required_skills.skills,
  required_skills.demand_count,
  ROUND(paying_skills.avg_salary) AS avg_salary
FROM
  required_skills
	INNER JOIN
	  paying_skills ON required_skills.skill_id = paying_skills.skill_id
ORDER BY
  demand_count DESC, 
	avg_salary DESC
LIMIT 20;
