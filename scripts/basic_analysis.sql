/*
====================================================================================
Analysis Script: Basic Analysis
====================================================================================
Script Purpose:
  This script performs basic exploratory analysis on the cleaned gun violence 
  dataset. Queries cover incident totals, casualty counts, mass shooting 
  identification, and incident distribution by state.
  Run this script after executing ddl_clean_gun_violence.sql.
====================================================================================
*/

-- Incident total 
SELECT 
    COUNT(incident_id) AS incident_total
FROM clean_gun_violence;

-- Incidents that resulted in death 
SELECT 
    COUNT(incident_id) AS incident_total
FROM clean_gun_violence
WHERE n_killed > 0;

-- Total mass shooting incidents (3+ killed, FBI definition, excluding shooter not accounted for in this dataset)
SELECT 
    COUNT(incident_id) AS incident_total
FROM clean_gun_violence
WHERE n_killed >= 3;

-- Total incidents by state
SELECT 
    incident_state,
    COUNT(incident_id) AS incident_total
FROM clean_gun_violence
GROUP BY incident_state
ORDER BY incident_total DESC;

-- Total casualities (n_killed + n_injured) 
SELECT
    SUM(n_killed) AS total_killed,
    SUM(n_injured) AS total_injured,
    SUM(n_killed + n_injured) AS total_casualties
FROM clean_gun_violence;
