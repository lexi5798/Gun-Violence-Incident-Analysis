/*
====================================================================================
Tableau Export Scripts: Gun Violence Incident Analysis
====================================================================================
Script Purpose:
  This script generates the three CSV exports used to build the Tableau Public
  dashboard. Queries cover state-level incident concentration and casualties,
  incident severity tier distribution, and monthly incident trends by year.
  Run this script after executing ddl_clean_gun_violence.sql.
====================================================================================
*/

-- Incidents by state
SELECT 
	incident_state,
	COUNT (incident_id) as incident_total,
	SUM (n_killed) as total_killed,
	SUM (n_injured) as total_injured,
	SUM (n_injured + n_killed) as total_casualities 
FROM clean_gun_violence
GROUP BY incident_state
ORDER BY incident_state;

-- Severity tier
WITH severity AS (
    SELECT
        CASE 
            WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
            WHEN n_killed = 0 AND n_injured BETWEEN 2 AND 3 THEN 'Medium'
            WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
            WHEN n_killed >= 3 THEN 'Mass Casualty'
        END AS severity_level
    FROM clean_gun_violence
)
SELECT severity_level, COUNT(*) AS incident_total
FROM severity
GROUP BY severity_level;

-- Incidents by month and year (ignoring 2013 and 2018 because they are partial years)
SELECT 
    YEAR(incident_date) AS incident_year,
    MONTH(incident_date) AS incident_month,
    COUNT(*) AS incident_total
FROM clean_gun_violence
WHERE YEAR(incident_date) BETWEEN 2014 AND 2017
GROUP BY YEAR(incident_date), MONTH(incident_date)
ORDER BY incident_year, incident_month;
