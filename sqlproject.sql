# A. Overall Hiring Performance
-- Total candidates kitne hain?
-- Hired vs Not Hired candidates ka count kya hai?
-- Overall hiring rate kya hai?
-- Recruitment strategy-wise hiring performance kya hai?
-- B. Candidate Demographics
-- Gender-wise candidate distribution kya hai?
-- Gender-wise hiring rate kya hai?
-- Education level-wise candidate distribution kya hai?
-- Education level-wise hiring rate kya hai?
-- Age group-wise hiring performance kya hai?
-- Experience level-wise hiring performance kya hai?
-- C. Candidate Quality & Scores
-- Interview score ka hiring par kya impact hai?
-- Skill score ka hiring par kya impact hai?
-- Personality score ka hiring par kya impact hai?
-- High-performing candidates ka hiring rate kya hai?
-- Hired vs Not Hired candidates ke average scores me kya difference hai?
-- D. Experience & Previous Companies
-- Previous companies experience ka hiring par kya impact hai?
-- Experience years ke according average scores kya hain?
-- Experienced candidates ka hiring rate kya hai?
-- E. Distance & Candidate Accessibility
-- Distance from company ka hiring par kya impact hai?
-- Kya company ke paas rehne wale candidates zyada hire hote hain?
-- F. Top Candidates & Hiring Insights
-- Top 10 highest interview score candidates kaun hain?
-- Top 10 highest skill score candidates kaun hain?
-- Combined scores ke basis par Top 10 candidates kaun hain?
-- Hired candidates ka average experience kitna hai?
-- Hired candidates ka average distance from company kitna hai?
-- G. Recruitment Strategy Analysis
-- Kaunsi recruitment strategy sabse zyada candidates hire karti hai?
-- Kaunsi recruitment strategy ki hiring rate highest hai?
-- Recruitment strategy aur education level ka combined analysis kya hai?
-- Recruitment strategy aur experience ka combined analysis kya hai?
-- Overall best candidate profile kya hai?



CREATE DATABASE hiremap_db;
USE hiremap_db;
describe sqlrawdata;
select * from  sqlrawdata limit 5;
#A. Overall Hiring Performance
select count(candidate_id) from sqlrawdata;
select count(Hiring_Decision_Name) from sqlrawdata where Hiring_Decision_Name="Hired";
select count(Hiring_Decision_Name) from sqlrawdata where Hiring_Decision_Name="Not Hired";
SELECT 
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata;

SELECT 
    RecruitmentStrategy,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
GROUP BY RecruitmentStrategy
ORDER BY hiring_rate DESC;
#B. Candidate Demographics
SELECT 
    Gender,
    COUNT(*) AS candidate_count
FROM sqlrawdata
GROUP BY Gender;

SELECT 
    Gender,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
GROUP BY Gender;
SELECT 
    EducationLevel,
    COUNT(*) AS candidate_count
FROM sqlrawdata
GROUP BY EducationLevel
ORDER BY candidate_count DESC;
SELECT 
    EducationLevel,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
GROUP BY EducationLevel
ORDER BY hiring_rate DESC;
SELECT 
    CASE
        WHEN Age < 25 THEN 'Below 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END AS age_group,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates
FROM sqlrawdata
GROUP BY
    CASE
        WHEN Age < 25 THEN 'Below 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        ELSE '45+'
    END;

SELECT 
    ExperienceYears,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates
FROM sqlrawdata
GROUP BY ExperienceYears
ORDER BY ExperienceYears;

#C. Candidate Quality & Scores
SELECT 
    HiringDecision,
    ROUND(AVG(InterviewScore), 2) AS average_interview_score
FROM sqlrawdata
GROUP BY HiringDecision;

SELECT 
    HiringDecision,
    ROUND(AVG(SkillScore), 2) AS average_skill_score
FROM sqlrawdata
GROUP BY HiringDecision;

SELECT 
    HiringDecision,
    ROUND(AVG(PersonalityScore), 2) AS average_personality_score
FROM sqlrawdata
GROUP BY HiringDecision;

SELECT 
    COUNT(*) AS high_performing_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
WHERE InterviewScore >= 80
  AND SkillScore >= 80
  AND PersonalityScore >= 80;
SELECT 
    HiringDecision,
    ROUND(AVG(InterviewScore), 2) AS avg_interview_score,
    ROUND(AVG(SkillScore), 2) AS avg_skill_score,
    ROUND(AVG(PersonalityScore), 2) AS avg_personality_score
FROM sqlrawdata
GROUP BY HiringDecision;
#D. Experience & Previous Companies
SELECT 
    PreviousCompanies,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
GROUP BY PreviousCompanies
ORDER BY PreviousCompanies;

SELECT 
    ExperienceYears,
    ROUND(AVG(InterviewScore), 2) AS avg_interview_score,
    ROUND(AVG(SkillScore), 2) AS avg_skill_score,
    ROUND(AVG(PersonalityScore), 2) AS avg_personality_score
FROM sqlrawdata
GROUP BY ExperienceYears
ORDER BY ExperienceYears;
SELECT 
    CASE
        WHEN ExperienceYears = 0 THEN 'Fresher'
        WHEN ExperienceYears BETWEEN 1 AND 3 THEN '1-3 Years'
        WHEN ExperienceYears BETWEEN 4 AND 6 THEN '4-6 Years'
        ELSE '7+ Years'
    END AS experience_group,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
GROUP BY
    CASE
        WHEN ExperienceYears = 0 THEN 'Fresher'
        WHEN ExperienceYears BETWEEN 1 AND 3 THEN '1-3 Years'
        WHEN ExperienceYears BETWEEN 4 AND 6 THEN '4-6 Years'
        ELSE '7+ Years'
    END;
#E. Distance & Candidate Accessibility

SELECT 
    CASE
        WHEN DistanceFromCompany <= 10 THEN 'Near'
        WHEN DistanceFromCompany <= 30 THEN 'Moderate'
        ELSE 'Far'
    END AS distance_group,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
GROUP BY
    CASE
        WHEN DistanceFromCompany <= 10 THEN 'Near'
        WHEN DistanceFromCompany <= 30 THEN 'Moderate'
        ELSE 'Far'
    END;

SELECT 
    DistanceFromCompany,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates
FROM sqlrawdata
GROUP BY DistanceFromCompany
ORDER BY DistanceFromCompany;
#F. Top Candidates & Hiring Insights
SELECT *
FROM sqlrawdata
ORDER BY InterviewScore DESC
LIMIT 10;
SELECT *
FROM sqlrawdata
ORDER BY SkillScore DESC
LIMIT 10;
SELECT 
    Candidate_id,
    InterviewScore,
    SkillScore,
    PersonalityScore,
    (InterviewScore + SkillScore + PersonalityScore) AS total_score,
    HiringDecision
FROM sqlrawdata
ORDER BY total_score DESC
LIMIT 10;

SELECT 
    ROUND(AVG(ExperienceYears), 2) AS avg_experience_hired
FROM sqlrawdata
WHERE HiringDecision = 1;

SELECT 
    ROUND(AVG(DistanceFromCompany), 2) AS avg_distance_hired
FROM sqlrawdata
WHERE HiringDecision = 1;

SELECT 
    RecruitmentStrategy,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates
FROM sqlrawdata
GROUP BY RecruitmentStrategy
ORDER BY hired_candidates DESC
LIMIT 1;

SELECT 
    RecruitmentStrategy,
    ROUND(
        SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS hiring_rate
FROM sqlrawdata
GROUP BY RecruitmentStrategy
ORDER BY hiring_rate DESC
LIMIT 1;

SELECT 
    RecruitmentStrategy,
    EducationLevel,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates
FROM sqlrawdata
GROUP BY RecruitmentStrategy, EducationLevel
ORDER BY RecruitmentStrategy, hired_candidates DESC;

SELECT 
    RecruitmentStrategy,
    ExperienceYears,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates
FROM sqlrawdata
GROUP BY RecruitmentStrategy, ExperienceYears
ORDER BY RecruitmentStrategy, ExperienceYears;

SELECT 
    EducationLevel,
    ExperienceYears,
    ROUND(AVG(InterviewScore), 2) AS avg_interview_score,
    ROUND(AVG(SkillScore), 2) AS avg_skill_score,
    ROUND(AVG(PersonalityScore), 2) AS avg_personality_score,
    COUNT(*) AS total_candidates,
    SUM(CASE WHEN HiringDecision = 1 THEN 1 ELSE 0 END) AS hired_candidates
FROM sqlrawdata
GROUP BY EducationLevel, ExperienceYears
ORDER BY hired_candidates DESC
LIMIT 10;
ALTER TABLE sqlrawdata
RENAME COLUMN `ï»¿Age` TO Age;
