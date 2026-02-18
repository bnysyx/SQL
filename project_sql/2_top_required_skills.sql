-- What are the required skills for the top 10 paying jobs


WITH top_paying_jobs AS (
SELECT
    job_id,
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
LIMIT 10
)

-- Choose this code to get count
SELECT 
    Count(top_paying_jobs.job_id) AS count_jobs,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
GROUP BY skills
ORDER BY count_jobs DESC;

/* Original Results:
"count_jobs","skills"
"8","sql"
"7","python"
"6","tableau"
"4","r"
"3","snowflake"
"3","pandas"
"3","excel"
"2","atlassian"
"2","jira"
"2","aws"
"2","azure"
"2","bitbucket"
"2","confluence"
"2","gitlab"
"2","go"
"2","numpy"
"2","oracle"
"2","power bi"
"1","jenkins"
"1","crystal"
"1","powerpoint"
"1","pyspark"
"1","hadoop"
"1","git"
"1","sap"
"1","jupyter"
"1","flow"
"1","databricks"


-- Choose this code to get salary by skill
SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;

*/
