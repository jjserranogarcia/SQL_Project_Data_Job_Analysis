/*
Question: What are the top-paying Data Analyst & Business Analyst jobs, and what skills are required?
— Identify the top 10 highest-paying Data Analyst & Business Analyst jobs and the specific skills 
  required for these roles.
— Filters for roles with specified salaries that are available in the EU.
— Why? It provides a detailed look at which high-paying jobs demand certain skills, 
  helping job seekers understand which skills to develop that align with top salaries.
*/

WITH top_paying_jobs AS (

    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name

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

    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills

FROM 
    top_paying_jobs

INNER JOIN skills_job_dim
    ON top_paying_jobs.job_id = skills_job_dim.job_id

INNER JOIN skills_dim
    ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
    salary_year_avg DESC;

/*

ChatGPT Insights from the Data on Skills Frequency:
  - Core Skills: SQL, Python, and Spark form the core technical skills in demand for data-related roles, emphasizing the importance of database management, programming, and big data processing.
  - Supporting Skills: Cloud platforms (AWS, Azure), version control (Git, GitHub), and visualization tools (Power BI, Tableau) are also valued, although to a lesser extent.
  - Specialized Tools: Technologies like Hadoop, while less frequently mentioned, remain relevant in specific contexts where large-scale data processing is required.
  
  [
  {
    "job_id": 1202839,
    "job_title": "Technology Research Engineer for Power Semiconductors (f/m/div.)",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 1202839,
    "job_title": "Technology Research Engineer for Power Semiconductors (f/m/div.)",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skills": "github"
  },
  {
    "job_id": 21632,
    "job_title": "Research Engineer - Physics (H/F)",
    "salary_year_avg": "200000.0",
    "company_name": "Withings",
    "skills": "python"
  },
  {
    "job_id": 21632,
    "job_title": "Research Engineer - Physics (H/F)",
    "salary_year_avg": "200000.0",
    "company_name": "Withings",
    "skills": "c"
  },
  {
    "job_id": 107183,
    "job_title": "Research Engineer (f/m/div.)",
    "salary_year_avg": "200000.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 1426728,
    "job_title": "Research Engineer (partial work abroad)",
    "salary_year_avg": "200000.0",
    "company_name": "WINGS-ICT-SOLUTIONS",
    "skills": "python"
  },
  {
    "job_id": 1426728,
    "job_title": "Research Engineer (partial work abroad)",
    "salary_year_avg": "200000.0",
    "company_name": "WINGS-ICT-SOLUTIONS",
    "skills": "java"
  },
  {
    "job_id": 156108,
    "job_title": "Research Engineer for Security and Privacy  (f/m/div.)",
    "salary_year_avg": "199675.0",
    "company_name": "Bosch Group",
    "skills": "spark"
  },
  {
    "job_id": 156108,
    "job_title": "Research Engineer for Security and Privacy  (f/m/div.)",
    "salary_year_avg": "199675.0",
    "company_name": "Bosch Group",
    "skills": "github"
  },
  {
    "job_id": 111632,
    "job_title": "Applied Scientist",
    "salary_year_avg": "194500.0",
    "company_name": "Etsy",
    "skills": "linux"
  },
  {
    "job_id": 111632,
    "job_title": "Applied Scientist",
    "salary_year_avg": "194500.0",
    "company_name": "Etsy",
    "skills": "git"
  },
  {
    "job_id": 20066,
    "job_title": "Business Intelligence Engineer, Sponsored TV",
    "salary_year_avg": "185000.0",
    "company_name": "Amazon",
    "skills": "sql"
  },
  {
    "job_id": 20066,
    "job_title": "Business Intelligence Engineer, Sponsored TV",
    "salary_year_avg": "185000.0",
    "company_name": "Amazon",
    "skills": "python"
  },
  {
    "job_id": 20066,
    "job_title": "Business Intelligence Engineer, Sponsored TV",
    "salary_year_avg": "185000.0",
    "company_name": "Amazon",
    "skills": "aws"
  },
  {
    "job_id": 24675,
    "job_title": "Staff Research Engineer",
    "salary_year_avg": "177283.0",
    "company_name": "ServiceNow",
    "skills": "nosql"
  },
  {
    "job_id": 24675,
    "job_title": "Staff Research Engineer",
    "salary_year_avg": "177283.0",
    "company_name": "ServiceNow",
    "skills": "azure"
  },
  {
    "job_id": 24675,
    "job_title": "Staff Research Engineer",
    "salary_year_avg": "177283.0",
    "company_name": "ServiceNow",
    "skills": "aws"
  },
  {
    "job_id": 24675,
    "job_title": "Staff Research Engineer",
    "salary_year_avg": "177283.0",
    "company_name": "ServiceNow",
    "skills": "spark"
  },
  {
    "job_id": 24675,
    "job_title": "Staff Research Engineer",
    "salary_year_avg": "177283.0",
    "company_name": "ServiceNow",
    "skills": "hadoop"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "sql"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "python"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "tableau"
  },
  {
    "job_id": 59701,
    "job_title": "Head of Data Analytics",
    "salary_year_avg": "166419.5",
    "company_name": "Volt.io",
    "skills": "power bi"
  }
]
*/