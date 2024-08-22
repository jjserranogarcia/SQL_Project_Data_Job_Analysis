/*
Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill) 
for a Data Analyst and Business Analyst?
— Identify skills in high demand and associated with high average salaries for Data Analyst 
  and Business Analyst roles
— Concentrates on EU positions with specified salaries
— Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
  offering strategic insights for career development in data analysis.
*/

WITH skills_demand AS (
    -- Identifies skills in high demand for Data Analyst and Business Analyst roles
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        salary_year_avg IS NOT NULL 
        AND job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_location LIKE ANY (ARRAY[
            '%Austria%', '%Belgium%', '%Bulgaria%', '%Croatia%', '%Cyprus%', 
            '%Czech Republic%', '%Denmark%', '%Estonia%', '%Finland%', '%France%', 
            '%Germany%', '%Greece%', '%Hungary%', '%Ireland%', '%Italy%', 
            '%Latvia%', '%Lithuania%', '%Luxembourg%', '%Malta%', '%Netherlands%', 
            '%Poland%', '%Portugal%', '%Romania%', '%Slovakia%', '%Slovenia%', 
            '%Spain%', '%Sweden%'
        ]) 
    GROUP BY 
        skills_dim.skill_id, skills_dim.skills
),
average_salary AS (
    -- Skills with high average salaries for Data Analyst and Business Analyst roles
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(job_postings_fact.salary_year_avg)) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    WHERE
        salary_year_avg IS NOT NULL 
        AND job_title_short IN ('Data Analyst', 'Business Analyst')
        AND job_location LIKE ANY (ARRAY[
            '%Austria%', '%Belgium%', '%Bulgaria%', '%Croatia%', '%Cyprus%', 
            '%Czech Republic%', '%Denmark%', '%Estonia%', '%Finland%', '%France%', 
            '%Germany%', '%Greece%', '%Hungary%', '%Ireland%', '%Italy%', 
            '%Latvia%', '%Lithuania%', '%Luxembourg%', '%Malta%', '%Netherlands%', 
            '%Poland%', '%Portugal%', '%Romania%', '%Slovakia%', '%Slovenia%', 
            '%Spain%', '%Sweden%'
        ]) 
    GROUP BY 
        skills_job_dim.skill_id
)
-- Return high demand and high salaries for top 10 skills
SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN average_salary
    ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    demand_count DESC, 
    avg_salary DESC
LIMIT 10;
