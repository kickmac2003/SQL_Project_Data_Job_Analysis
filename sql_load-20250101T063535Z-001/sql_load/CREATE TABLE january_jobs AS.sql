CREATE TABLE january_jobs AS
    SELECT*
    FROM
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 1;

SELECT*
    FROM
        job_postings_fact
    WHERE 
        EXTRACT(MONTH FROM job_posted_date) = 1;

SELECT
    count(job_title_short) AS job_count,
    job_schedule_type,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM
    job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date)=1 
GROUP BY job_schedule_type
HAVING count(job_title_short) >20
LIMIT 5;