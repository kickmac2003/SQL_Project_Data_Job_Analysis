-- January job postings
CREATE TABLE january_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February job postings
CREATE TABLE february_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March job postings
CREATE TABLE march_jobs AS
    SELECT *
    FROM
        job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT job_title_short
FROM february_jobs

CREATE TABLE Earnings(
    date DATE,
    income_source VARCHAR(255),
    company_name TEXT
);

INSERT INTO Earnings ( 
    date,
    income_source,
    company_name
)

VALUES
('2023-02-02','FOREX','Kickmac'),
('2023-03-03','Salary','IPL'),
('2023-04-04','FOREX','Pluto');


ALTER TABLE Earnings
ALTER column company_name TYPE VARCHAR(255);