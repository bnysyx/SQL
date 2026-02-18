-- What are the top 10 paying Data Analyst jobs world wide
SELECT
    job_title_short,
    job_title,
    salary_year_avg,
    cd.name
FROM job_postings_fact AS jpf
LEFT JOIN company_dim AS cd ON jpf.company_id = cd.company_id
WHERE
    --job_title_short IN ('Data Analyst') AND
    --job_work_from_home = True AND
    job_title_short IN ('Data Analyst','Senior Data Analyst') AND
    job_country = 'Germany' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

