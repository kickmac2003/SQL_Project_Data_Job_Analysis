/* This query identifies the top 5 most in-demand skills for Data Analyst roles in New York.
It achieves this by counting the occurrences of each skill associated with job postings for Data Analyst positions in New York.
The results are sorted by the frequency of the skills in descending order, highlighting the most sought-after skills for the role.
*/
SELECT
    skills_dim.skills AS high_demand_skills,
    COUNT(skills_job_dim.job_id) AS skill_count
FROM
    skills_dim
INNER JOIN
    skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id
INNER JOIN
    job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location like '%New York%'
GROUP BY
    skills_dim.skills
ORDER BY
    skill_count DESC
LIMIT 5;