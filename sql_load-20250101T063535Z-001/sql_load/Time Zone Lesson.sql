SELECT
    job_schedule_type,
    AVG(salary_year_avg),
    AVG(salary_hour_avg)
FROM
    job_postings_fact
WHERE
    job_posted_date::DATE > '2023-06-21'
GROUP BY
    job_schedule_type
ORDER BY
    job_schedule_type
LIMIT 5;

SELECT
    '24-12-1986'::DATE,
    'false' :: BOOLEAN,
    '3.13' :: REAL,
    '2324' :: INT;

SELECT
    job_title_short AS tiltle,
    job_schedule_type,
    job_posted_date :: DATE
FROM
    job_postings_fact
LIMIT 5;

SELECT
    job_posted_date AT TIME ZONE 'EST'
FROM
    job_postings_fact
LIMIT 5;

SELECT
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York',
    EXTRACT(MONTH FROM job_posted_date) AS posted_month,
    EXTRACT(YEAR FROM job_posted_date) AS posted_year
FROM
    job_postings_fact
LIMIT 5;

SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS posted_month,
    count(*) AS job_count
FROM
    job_postings_fact
GROUP BY
    posted_month;


SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(*) AS postings_count
FROM
    job_postings_fact
GROUP BY
    month
ORDER BY
    month;

