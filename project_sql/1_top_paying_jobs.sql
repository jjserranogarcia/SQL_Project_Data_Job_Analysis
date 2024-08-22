/*
Question: What are the top-paying Data Analyst & Business Analyst jobs?
— Identify the top 10 highest-paying Data Analyst & Business Analyst roles.
— Focuses on job postings with specified salaries that are available in the EU.
— Why? Aims to highlight the top-paying opportunities for Data Analyst & Business Analysts, 
  offering insights into employment options and location flexibility.
*/

SELECT
    job_id,
    job_title,
    job_title_short,
    name AS company_name,
    job_location,
    salary_year_avg,
    job_schedule_type,
    job_posted_date
    

FROM
    job_postings_fact
    LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short IN ('Data Analyst','Business Analyst') AND
    job_location LIKE ANY (ARRAY[
    '%Austria%', '%Belgium%', '%Bulgaria%', '%Croatia%', '%Cyprus%', 
    '%Czech Republic%', '%Denmark%', '%Estonia%', '%Finland%', '%France%', 
    '%Germany%', '%Greece%', '%Hungary%', '%Ireland%', '%Italy%', 
    '%Latvia%', '%Lithuania%', '%Luxembourg%', '%Malta%', '%Netherlands%', 
    '%Poland%', '%Portugal%', '%Romania%', '%Slovakia%', '%Slovenia%', 
    '%Spain%', '%Sweden%'
    ]) AND
    salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC

LIMIT 10;

