# Introduction
🌍 Eager to dive into the world of data analytics jobs in the EU?

Discover the highest-paying roles for data analysts and business analysts, and uncover the essential skills you need to excel in these positions. 

🔗 Access the SQL queries that powered these insights here: [project_sql folder](/project_sql/)

 # Background
Starting out in the field of data analytics, I decided to explore the job market to identify the most valuable skills to learn.

### This project explores the following key questions:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
- **SQL**: To efficiently extract and analyze the necessary data.
- **PostgreSQL**: Ideal for managing and processing job market data.
- **Visual Studio Code**: Used for writing and executing SQL queries.
- **Git & GitHub**: Essential for version control and collaboration.
- **Excel**: Utilized for creating clear and insightful data visualizations.

# The Analysis

I broke down each key question into specific queries:

### 1. What are the top-paying Data Analyst & Business Analyst jobs? ###  

   I identified the top 10 highest-paying roles in the EU for data analysts and business analysts by filtering data based on job title, average yearly salary, and location.
    
``` sql
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
```
![Top Paying Roles](assets\1_top_paying_roles.jpg)

*Bar graph visualising the salary for the top 10 salaries for data analysts and business analysts*
### 2. What are the top-paying Data Analyst & Business Analyst jobs, and what skills are required? ###  
   For the top-paying jobs identified, I analyzed the specific skills required for each role.
```sql
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
```
![Top Paying Roles Skills](assets\2_top_paying_jobs_skills.jpg)

*Bar graph visualising the skill count for the top paying roles for data analysts and business analysts*

### 3. What are the most in-demand skills for Data Analysts and Business Analysts? ###  
   I aggregated the skills required for these roles across the EU and identified the top 5 most in-demand skills.
```sql
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
```

| Skills   | Demand Count |
|----------|--------------|
| SQL      | 28,550        |
| Python   | 18,920        |
| Excel    | 18,543        |
| Power BI | 14,690        |
| Tableau  | 12,710        |


### 4. What are the top skills based on salary? ### 
   I filtered data from all relevant job postings in the EU to identify the top 25 highest-paying skills.
```sql
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

LIMIT 10;
```


| Skills     | Avg Salary  |
|------------|-------------|
| Mongo      | 165,000     |
| Unify      | 163,782     |
| Smartsheet | 155,000     |
| C          | 143,200     |
| Spring     | 140,905     |
| NoSQL      | 135,419     |
| Flask      | 126,040     |
| Slack      | 126,000     |
| Linux      | 123,901     |
| Terraform  | 120,067     |

### 5. What are the most optimal skills to learn for a Data Analyst and Business Analyst? ### 
   I combined the results from previous analyses to determine which skills are both highly demanded and command higher salaries, ensuring the recommended skills offer the best return on investment.
```sql
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
```

| Skill ID | Skills   | Demand Count | Average Salary ($)|
|----------|----------|--------------|------------|
| 0        | SQL      | 219          | 92,893     |
| 1        | Python   | 156          | 94,176     |
| 182      | Tableau  | 118          | 88,964     |
| 181      | Excel    | 98           | 77,291     |
| 183      | Power BI | 76           | 87,602     |
| 5        | R        | 57           | 89,406     |
| 74       | Azure    | 49           | 109,609    |
| 92       | Spark    | 43           | 109,633    |
| 185      | Looker   | 34           | 98,792     |
| 189      | SAP      | 34           | 89,855     |

# What I learned
This project has improved my data analytics skills, enhancing both my technical proficiency and analytical capabilities:

**👨🏻‍💻 Advanced SQL Techniques:** Expanded my expertise with advanced SQL features, such as JOINs and subqueries, and leveraged powerful tools like CTEs to handle intricate data scenarios with ease.

**✨ Problem Solving:** Tackled various challenges, from troubleshooting query errors to optimizing performance. Each problem sharpened my ability to analyze and interpret results more effectively.

**📊 Data Aggregation:** Mastered the use of aggregation techniques, including GROUP BY and functions like COUNT and AVG, to summarize and extract meaningful insights from complex datasets.

# Conclusions

### 1. Top-Paying Data Analyst & Business Analyst Jobs: ###

 The highest-paying roles in the EU for data analysts and business analysts offer impressive salaries up to $200,000. Many of these positions are categorized under the title of Research Engineer.

### 2. Skills for Top-Paying Jobs: ### 

To secure these high-paying roles, advanced proficiency in SQL, Python, and Spark is essential. These skills are crucial for excelling in top-tier positions.

### 3. Most In-Demand Skills: ### 

SQL and Python are among the most sought-after skills in the data analyst and business analyst job markets. Additionally, skills in Excel and data visualization tools such as Power BI and Tableau are also highly demanded.

### 4. Skills with Higher Salaries: ### 

Top-paying skills often involve specialized software programs, such as MongoDB and Unify. These niche expertise areas are linked to the highest average salaries, indicating their premium value in the job market.

### 5. Optimal Skills for Job Market Value: ###  

SQL and Python not only top the list in terms of demand but also offer competitive salaries. Mastering these skills, along with Excel and advanced visualization tools, positions candidates favorably in the job market, enhancing their potential for high earnings.
