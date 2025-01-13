# Introduction
This project explores the job market💼in the field of Data Analytics📊 to uncover key insights🔎, including the most in-demand skills🌟 for data analysts, the highest-paying skills💸, and the skills that provide both job security and financial benefits. The findings aim to guide job seekers in identifying essential skills to thrive as a data analyst in today’s competitive market📈.

👉 Check out the SQL queries here:  [project_sql folder](/sql_project/)
# Background
Motivated to apply my newly acquired SQL skills, I undertook this project to analyze the 2023 Data Analyst job market using job postings. The goal is to provide job seekers and other stakeholders in data analytics with insights into the most in-demand and top-paying skills, what I term 'optimal skills.' This analysis aims to guide individuals in prioritizing skill investments for securing high-value opportunities.

The data for this project was sourced from Luke Barousse's [SQL Course](https://www.lukebarousse.com/sql). 

### The following research questions guided my SQL queries:

1. What are the top-paying data analyst jobs?
2. What skills are required for these high-paying roles?
3. Which skills are most frequently required by employers for data analyst positions?
4. What are the skills associated with higher salaries?
5. What are the most valuable skills to acquire for optimal career prospects?

# Tool Used
To conduct an in-depth analysis of the data analyst job market, I leveraged a combination of powerful tools:

- **SQL**: Served as the foundation of my analysis, enabling me to extract valuable insights from the database.

- **PostgreSQL**: Provided a robust database management system, perfectly suited for handling and analyzing job posting data.

- **Visual Studio Code**: Served as my primary interface for database management and executing SQL queries.

- **Git & GitHub**: Facilitated version control, collaboration, and project tracking by enabling me to share and manage my SQL scripts and analysis.

# The Analysis
To gain insights into the data analyst job market, I developed a series of targeted queries. Here's how I approached each research question:

### 1. Top-Paying Data Analyst Jobs

To pinpoint the most lucrative data analyst roles, I filtered job postings by average annual salary and location, with a specific focus on New York, USA. This query reveals the highest-paying opportunities in the field, providing valuable information for job seekers and industry professionals alike.
```sql
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
```

### Here's the overview of the top Data Analyst jobs in 2023:

- **Investigations and Insights Lead Data   Analyst at TikTok is the highest-paying role:** This specific role appears multiple times in the top 10, indicating high demand and compensation within TikTok.

- **Salaries exhibit significant variation:** The average annual salary ranges from $175,000 to $240,000, highlighting a substantial disparity in compensation across different data analyst roles.

- **Data Sector Analyst - Hedge Fund offers the highest average salary:** At $240,000, this role stands out as the most lucrative among the listed positions.

![Top Paying Roles](assets\1_top_paying_jobs.jpg)
*Bar graph visualizing the salary for the top 10 salaries for data analysts; ChatGPT generated this graph from my SQL query results*

### 2. Skills associated with the Top Paying Data Analyst jobs

This query built upon Query 1 and was designed to answer the question: What skills were associated with the top 10 Data Analyst job postings? To obtain the answers, I joined the job postings with the skills data, providing insights into what employers valued for high-compensation roles.
```sql
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
    required_skills.salary_year_avg DESC;
```
Here's an overview of the key skills that are most sought after in the top 10 highest-paying data analyst positions for 2023:

- **SQL** and **Python** are the most frequently required skills for top-paying Data Analyst roles, appearing in 7 job postings each.

- **R** and **Express** are also popular, listed in 3 postings each.
Excel and Tableau, commonly associated with data analysis and visualization, appear in 2 postings each.
- Advanced tools like **Spark**, **Hadoop**, and **Cassandra** are less common but still listed, indicating niche requirements for some roles.

These insights suggest that proficiency in **SQL**, **Python**, and common data analysis tools like **Excel** and **Tableau** 
is critical for Data Analyst roles, while knowledge of additional technologies like **R** or **big data tools** can be advantageous.

![Top 10 Skills for Top Payin Jobs](assets\2_top_10_skills.jpg)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query results*

### 3. In-Demand Skills for Data Analysts ###
This query answered: Which skills are most frequently required by employers for data analyst positions?
It achieved this by counting the occurrences of each skill associated with job postings for Data Analyst jobs.
The results were sorted by the frequency of the skills in descending order, highlighting the most sought-after skills.
```sql
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
```

Here's the analysis of the most demanded skills for data analysts in 2023:

- **SQL and Excel remain dominant:** SQL and Excel continue to be the most in-demand skills, with counts of 1755 and 1328 respectively. This indicates a strong need for both relational database skills and spreadsheet proficiency in the job market.

- **Python and R are essential for data science:** Python and R, with counts of 1022 and 577, respectively, are crucial for data analysis, machine learning, and statistical computing. Their presence highlights the growing importance of data science and advanced analytical skills in the job market.
- **Tableau** remains one of the best skills for data visualization.

| Skills   | Demand Count   |
|----------|----------------|
| SQL      | 1755           |
| Excel    | 1358           |
| Python   | 1022           |
| Tableau  | 999            |
| R        | 577            |

*Table of the demand for the top 5 skills in data analyst job postings.*

### 4. Top Paying Skills ###

This query identifies the top 10 high-paying skills for Data Analyst postions in 2023, 
based on the average annual salary. The query calculates the average salary for each skill 
and orders them in descending order of their average salaries.
```sql
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
```
Here are some quick insights into some trends into the top paying Data Analyst roles:

- **Top Skills:** Elasticsearch and Neo4j lead with average salaries of $185,000.

- **High Demand Tech**: Skills in Cassandra, dplyr, and Unix, with salaries ranging from $162,500 to $175,000.

- **Diverse Tools:** Valuable knowledge includes Perl, Twilio, and Spring, offering salaries between $147,500 and $157,000.

| Skill         | Average Salary ($) |
|---------------|--------------------|
| elasticsearch | 185000             |
| neo4j         | 185000             |
| cassandra     | 175000             |
| dplyr         | 167500             |
| unix          | 162500             |
| perl          | 157000             |
| twilio        | 150000             |
| spring        | 147500             |
| c             | 146500             |
| angular       | 138516             |
*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Valuable Skills for Optimal Career Prospects

This query combined demand and salary data to identify skills that are both highly sought-after and well-paying, providing a strategic guide for prioritizing skill development.
```sql
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
```
Here's the overview of the most favourable skills for Data Analysts in 2023:

- **High Demand for SQL and Excel Skills:** SQL and Excel are the most frequently required skills, with demand counts of 1755 and 1328, respectively. These skills are foundational in the data analysis field and are highly sought after by employers.

- **High Average Salaries for Technical Skills:** Skills like Python, SQL Server, and Snowflake offer some of the highest average salaries, reflecting their importance in modern data analysis and data engineering roles.

- **Wide Range of Skills in Demand:** The data shows a diverse set of skills in demand, from programming languages like Python and R to tools like Tableau and Power BI, indicating the multifaceted nature of data analyst roles.

| Skill       | Demand Count | Average Salary ($) |
| Skill       | Demand Count | Average Salary ($) |
|-------------|--------------|--------------------|
| sql         | 1755         | 104420             |
| excel       | 1328         | 92083              |
| python      | 1022         | 109362             |
| tableau     | 999          | 99802              |
| r           | 577          | 96147              |
| power bi    | 463          | 95440              |
| powerpoint  | 371          | 98165              |
| word        | 321          | 91650              |
| sas         | 246          | 82010              |
| oracle      | 213          | 97587              |
*Table of the most optimal skills for data analyst*

# What I Learned
Through this SQL project, I gained several valuable skills and insights:

- **Proficiency with Common Table Expressions (CTEs)** 

    Working with CTEs has transformed how I structure my queries. I learned how to break down complex problems into manageable steps, making my code more readable, organized, and efficient.

- **Enhanced Analytical Skills**

    This project required me to analyze data deeply to extract meaningful insights. My ability to interpret data trends and connect them to real-world contexts has significantly improved, which is critical for decision-making.

- **Complex Query Crafting**

    I developed the ability to write advanced SQL queries by integrating multiple joins, subqueries, and aggregation techniques. This skill has equipped me to handle more intricate data challenges.

- **Error Handling and Debugging**
    I learned how to identify and resolve query errors efficiently. This experience taught me the importance of attention to detail and persistence in troubleshooting.

This project was nothing but a comprehensive learning experience that sharpened my technical and analytical abilities. It gave me confidence in tackling more real-world data problems effectively.

# Conclusion

This project uncovered valuable insights into the data analyst job market, specifically focusing on salary trends, skill demand, and market optimization:

1.  **Top-Paying Data Analyst Jobs**

    The highest-paying data analyst role in New York is the Data Sector Analyst - Hedge Fund, offering a remarkable annual salary of $240,000.

2. **Skills for Top-Paying Jobs**

    The skills most commonly associated with top-paying roles are SQL and Python, underscoring their critical importance in the field.

3. **Most In-Demand Skill**

    SQL emerges as the most sought-after skill, making it indispensable for aspiring data analysts.

4. **Skills Commanding Higher Salaries**

    Specialized skills such as Elasticsearch and Neo4j are linked to higher salaries, highlighting their value in niche areas of data analysis.

5. **Optimal Skills for Market Value**

    SQL stands out as a dual-purpose skill, leading in demand while also being associated with high average salaries. This makes it a strategic focus for anyone looking to enhance their career prospects and maximize market value.

These findings provide a roadmap for job seekers and professionals in the data analytics space, helping them prioritize skill development to align with market demands and opportunities.


