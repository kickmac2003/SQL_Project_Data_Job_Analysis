/*This query builds upon Query 1 and is designed to answer the question:
What are the skills associated with the top 10 Data Analyst job postings in New York?

In this query:

1. A Common Table Expression (CTE) named top_skills is used to retrieve the top 10 Data Analyst job postings in New York, 
ranked by their average annual salary (salary_year_avg) in descending order. Only jobs with a non-null salary are included in this selection.

2.The main query joins the 'top_skills' CTE with the skills_job_dim and skills_dim tables to identify the skills associated with each job posting.

3.The STRING_AGG() function is used to aggregate all skills for each job into a single string, separated by commas. 
This ensures that each job posting appears only once in the final output, with its associated skills grouped together.

4.The results are grouped by the job's unique identifier (job_id), title, and salary, and are then ordered by the salary in descending order.

 */

WITH required_skills AS (
    SELECT
    job_id,
    job_title,
    salary_year_avg,
    company_dim.name AS company_name   
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
    LIMIT 10
)

SELECT
    required_skills.job_id,
    required_skills.job_title,
    required_skills.salary_year_avg,
    STRING_AGG(skills_dim.skills, ', ' ) AS skills -- This Combine all skills into one column
FROM
    required_skills
INNER JOIN
    skills_job_dim ON required_skills.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY
    required_skills.job_id,
    required_skills.job_title,
    required_skills.salary_year_avg
ORDER BY
    required_skills.salary_year_avg DESC
LIMIT 10;



/* Insights from the "Skills" Column Analysis:

SQL and Python are the most frequently required skills for Data Analyst roles, appearing in 7 job postings each.
R and Express are also popular, listed in 3 postings each.
Excel and Tableau, commonly associated with data analysis and visualization, appear in 2 postings each.
Advanced tools like Spark, Hadoop, and Cassandra are less common but still listed, indicating niche requirements for some roles.
These insights suggest that proficiency in SQL, Python, and common data analysis tools like Excel and Tableau 
is critical for Data Analyst roles, while knowledge of additional technologies like R or big data tools can be advantageous.

[
  {
    "job_id": 339646,
    "job_title": "Data Sector Analyst - Hedge Fund in Midtown",
    "salary_year_avg": "240000.0",
    "skills": "pandas, sql, python"
  },
  {
    "job_id": 841064,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "sql, express, python, r"
  },
  {
    "job_id": 1713491,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "skills": "express, sql, python, r"
  },
  {
    "job_id": 204500,
    "job_title": "Reference Data Analyst",
    "salary_year_avg": "225000.0",
    "skills": "sql, python"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "skills": "oracle, sql, neo4j, elasticsearch, sql server, aws, spark, kafka"
  },
  {
    "job_id": 396924,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "skills": "sql, python, r, express"
  },
  {
    "job_id": 386504,
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "skills": "python, excel, tableau, power bi"
  },
  {
    "job_id": 1293960,
    "job_title": "Data Research Analyst",
    "salary_year_avg": "175000.0",
    "skills": "sql, python, java, cassandra, spark, hadoop, tableau"
  }
]

*/

