SELECT
    job_title_short,
    COUNT(job_id) AS posting_count,
    MIN(salary_year_avg)::INT AS min_salary,
    AVG(salary_year_avg)::INT AS average_salary,
    Max(salary_year_avg)::INT AS max_salary
FROM job_postings_fact
WHERE 
    job_country = 'Germany' AND
    job_schedule_type = 'Full-time' AND
    salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY average_salary DESC

-- ------------------------------------------------------------

SELECT
    job_postings_fact.job_title_short,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date::DATE,
    company_dim.name
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_country = 'Germany' AND
    job_schedule_type = 'Full-time' AND
    job_title_short IN ('Data Analyst','Senior Data Analyst') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC

-- ------------------------------------------------------------

WITH salary_calc AS ( -- Create Average Salary per Title
    SELECT
        job_title_short,
        AVG(salary_year_avg)::INT AS average_salary
    FROM job_postings_fact
    WHERE 
        job_country = 'Germany' AND
        job_schedule_type = 'Full-time' AND
        salary_year_avg IS NOT NULL
    GROUP BY job_title_short
),

job_postings_added AS ( -- Join Average Salary per Title
    SELECT 
        job_postings_fact.job_title_short,
        job_postings_fact.salary_year_avg,
        job_postings_fact.job_posted_date,
        salary_calc.average_salary,
        job_postings_fact.company_id,
        job_postings_fact.job_country,
        job_postings_fact.job_schedule_type
    FROM job_postings_fact
    LEFT JOIN salary_calc ON job_postings_fact.job_title_short = salary_calc.job_title_short
)

SELECT
    job_postings_added.job_title_short,
    job_postings_added.salary_year_avg,
    job_postings_added.job_posted_date::DATE,
    job_postings_added.average_salary,
    company_dim.name
FROM job_postings_added
LEFT JOIN company_dim ON job_postings_added.company_id = company_dim.company_id
WHERE 
    job_country = 'Germany' AND
    job_schedule_type = 'Full-time' AND
    job_title_short IN ('Data Analyst','Senior Data Analyst')
ORDER BY
    salary_year_avg DESC

