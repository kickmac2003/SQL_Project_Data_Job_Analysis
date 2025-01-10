/* This query identifies the top high-paying skills for Data Analyst roles in New York, 
based on the average annual salary. The query calculates the average salary for each skill 
and orders them in descending order of their average salaries.*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%New York%' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 20;


/* 
    Here are some quick insights into some trends into the top paying Data Analyst roles:

-Top Skills: Elasticsearch and Neo4j lead with average salaries of $185,000.

-High Demand Tech: Skills in Cassandra, dplyr, and Unix, with salaries ranging from $162,500 to $175,000.

-Diverse Tools: Valuable knowledge includes Perl, Twilio, and Spring, offering salaries between $147,500 and $157,000.


[
  {
    "skills": "elasticsearch",
    "avg_salary": "185000"
  },
  {
    "skills": "neo4j",
    "avg_salary": "185000"
  },
  {
    "skills": "cassandra",
    "avg_salary": "175000"
  },
  {
    "skills": "dplyr",
    "avg_salary": "167500"
  },
  {
    "skills": "unix",
    "avg_salary": "162500"
  },
  {
    "skills": "perl",
    "avg_salary": "157000"
  },
  {
    "skills": "twilio",
    "avg_salary": "150000"
  },
  {
    "skills": "spring",
    "avg_salary": "147500"
  },
  {
    "skills": "c",
    "avg_salary": "146500"
  },
  {
    "skills": "angular",
    "avg_salary": "138516"
  },
  {
    "skills": "gcp",
    "avg_salary": "135294"
  },
  {
    "skills": "kafka",
    "avg_salary": "135000"
  },
  {
    "skills": "pandas",
    "avg_salary": "133169"
  },
  {
    "skills": "scikit-learn",
    "avg_salary": "130000"
  },
  {
    "skills": "linux",
    "avg_salary": "127500"
  },
  {
    "skills": "shell",
    "avg_salary": "126250"
  },
  {
    "skills": "express",
    "avg_salary": "126005"
  },
  {
    "skills": "java",
    "avg_salary": "125147"
  },
  {
    "skills": "numpy",
    "avg_salary": "125062"
  },
  {
    "skills": "c++",
    "avg_salary": "124044"
  }
]

*/