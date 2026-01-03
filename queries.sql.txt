-- 1. Bütün layihələri gətir
SELECT
    id,
    name,
    city,
    country,
    technology,
    start_date,
    status
FROM gis_projects;


-- 2. Yalnız "completed" layihələr
SELECT
    *
FROM gis_projects
WHERE status = 'completed';


-- 3. PostGIS texnologiyalı layihələr
SELECT
    *
FROM gis_projects
WHERE technology = 'PostGIS';


-- 4. Şəhərə görə neçə layihə var
SELECT
    city,
    COUNT(*) AS project_count
FROM gis_projects
GROUP BY city
ORDER BY project_count DESC;


-- 5. 2024-dən sonra başlayan layihələr
SELECT
    *
FROM gis_projects
WHERE start_date >= DATE '2024-01-01'
ORDER BY start_date;
