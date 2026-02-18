

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) as demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    --job_title_short = 'Data Analyst' AND
    job_title_short IN ('Data Analyst','Senior Data Analyst') AND
    job_country = 'Germany'
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 10

/* Result
"skills","demand_count"
"sql","3616"
"python","2851"
"tableau","1796"
"power bi","1515"
"excel","1486"
"r","1384"
"sap","796"
"azure","522"
"sas","478"
"looker","413"
*/