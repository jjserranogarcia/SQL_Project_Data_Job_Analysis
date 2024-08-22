/*
Question: What are the top skills based on salary?
— Look at the average salary associated with each skill for Data Analyst and Business Analyst positions.
— Focuses on roles with specified salaries available in the EU.
— Why? It reveals how different skills impact salary levels for Data Analysts and Business Analyst,
  and helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT 
    skills,
    ROUND(AVG (salary_year_avg)) AS avg_salary

FROM 
    job_postings_fact

INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
salary_year_avg IS NOT NULL AND

        job_title_short IN ('Data Analyst','Business Analyst') AND
        job_location LIKE ANY (ARRAY[
        '%Austria%', '%Belgium%', '%Bulgaria%', '%Croatia%', '%Cyprus%', 
        '%Czech Republic%', '%Denmark%', '%Estonia%', '%Finland%', '%France%', 
        '%Germany%', '%Greece%', '%Hungary%', '%Ireland%', '%Italy%', 
        '%Latvia%', '%Lithuania%', '%Luxembourg%', '%Malta%', '%Netherlands%', 
        '%Poland%', '%Portugal%', '%Romania%', '%Slovakia%', '%Slovenia%', 
        '%Spain%', '%Sweden%'
        ]) 

GROUP BY 
    skills

ORDER BY
    avg_salary DESC

LIMIT 25;