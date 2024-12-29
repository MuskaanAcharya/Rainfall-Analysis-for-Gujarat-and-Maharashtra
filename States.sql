--create database 
CREATE DATABASE States;

GO
USE States;


select * from Rain;
select * from Gujarat;
select * from Maharashtra;

-- 1. Top 3 Years with Minimum Rainfall in Gujarat
SELECT TOP 3 YEAR, ANNUAL
FROM Rain
WHERE SUBDIVISION = 'GUJARAT REGION'
ORDER BY ANNUAL ASC;


--2. Top 3 Years with Maximum Rainfall in Maharashtra
SELECT TOP 3 YEAR, ANNUAL
FROM Rain
WHERE SUBDIVISION = 'MAHARASHTRA REGION'
ORDER BY ANNUAL DESC;


-- 3. How many times Gujarat and Maharashtra has rainfall higher than 200mm in month of September?
SELECT SUBDIVISION, COUNT(*)
FROM Rain
WHERE (SUBDIVISION = 'GUJARAT REGION' OR SUBDIVISION = 'MAHARASHTRA REGION') AND SEP > 200
GROUP BY SUBDIVISION;


-- 4.What is the Growth rate when MAHARASHTRA has maximum percentage share in India's population?
SELECT TOP 1 YEAR, GrowthRate, ShareIndia
FROM Maharashtra
ORDER BY ShareIndia DESC;

--Alternate way
SELECT TOP 1 YEAR, GrowthRate, ShareIndia
FROM Maharashtra
where ShareIndia = (Select max(shareindia) from MAHARASHTRA);


-- 5.  Fetch Rainfall, Population, population growth rate of GUJARAT and MAHARSHTRA in 1991
SELECT G.YEAR, G.Population AS Gujarat_Population, G.GrowthRate AS Gujarat_GrowthRate,
M.Population AS Maharashtra_Population, M.GrowthRate AS Maharashtra_GrowthRate, 
R1.ANNUAL AS Gujarat_Rainfall, R2.ANNUAL AS Maharashtra_Rainfall
FROM Gujarat G
JOIN Maharashtra M ON G.YEAR = M.YEAR AND G.YEAR = 1991
JOIN Rain R1 ON R1.YEAR = G.YEAR AND R1.SUBDIVISION = 'GUJARAT REGION'
JOIN Rain R2 ON R2.YEAR = M.YEAR AND R2.SUBDIVISION = 'MAHARASHTRA REGION';

--6.Which state experiences greater variation in Population growth year overyear?
SELECT TOP 1 State, STDEV(GrowthRate) AS Growth_Variation
FROM (
SELECT 'Gujarat' AS State, GrowthRate FROM GUJARAT
UNION ALL
SELECT 'Maharashtra' AS State, GrowthRate FROM MAHARASHTRA
) as combine
GROUP BY State
ORDER BY Growth_Variation DESC;


--7. Which state received more rainfall on average over a years 2011 to 2015
SELECT Top 1 SUBDIVISION, AVG(ANNUAL) AS Avg_Rainfall
FROM Rain
WHERE YEAR BETWEEN 2011 AND 2015 
GROUP BY SUBDIVISION
ORDER BY Avg_Rainfall DESC;













--QUERY 2
SELECT 
    (SELECT AVG(ANNUAL) FROM Rain WHERE YEAR BETWEEN 2011 AND 2015 AND SUBDIVISION = 'GUJARAT REGION') AS Avg_Rainfall_Gujarat,
    (SELECT AVG(ANNUAL) FROM Rain WHERE YEAR BETWEEN 2011 AND 2015 AND SUBDIVISION = 'MAHARASHTRA REGION') AS Avg_Rainfall_Maharashtra;


