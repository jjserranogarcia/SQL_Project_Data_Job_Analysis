/*
Question: What are the most in-demand skills for Data Analysts and Business Analysts?
— Identify the top 5 in-demand skills for Data Analysts and Business Analysts.
— Focus on all job postings available in the EU.
— Why? Retrieves the top 5 skills with the highest demand in the job market, 
  providing insights into the most valuable skills for job seekers.
*/

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count

FROM 
    job_postings_fact

INNER JOIN skills_job_dim
    ON job_postings_fact.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
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
    demand_count DESC

LIMIT 5;

/*
High-Paying Database and Integration Skills: Skills in NoSQL databases like Mongo and data integration tools like Unify are among the top earners, reflecting the demand for managing complex, unstructured data.

Valuable Programming and Infrastructure Expertise: Traditional programming languages (e.g., C, Spring) and DevOps tools (Terraform, Linux) are highly compensated, indicating the importance of robust programming and cloud infrastructure management in these roles.

Emerging and Specialized Technologies: Staying current with newer tools like Databricks and Smartsheet leads to higher salaries, highlighting the value of expertise in cutting-edge technologies within data-centric roles.
*/