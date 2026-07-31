/*
====================================================================================
Analysis Script: Advanced Analysis
====================================================================================
Script Purpose:
  This script performs advanced analysis on the cleaned gun violence dataset.
  Queries cover severity classification, temporal trend analysis, geographic 
  concentration, incident type breakdown, and escalation indicator identification
  across Mass Casualty events.
  Run this script after executing ddl_clean_gun_violence.sql.
====================================================================================
*/

-- Classifying incidents into harm severity tiers (low, medium, high, mass casualty) based on fatality and injury counts.
SELECT 
	incident_id, 
	incident_date,
	incident_state,
	n_killed, 
	n_injured, 
CASE WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
	WHEN n_killed = 0 AND  n_injured BETWEEN 2 AND 3 THEN 'Medium'
	WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
	WHEN n_killed >= 3 THEN 'Mass Casualty'
END AS severity_level
FROM clean_gun_violence;

-- Total incidents, killed, and injured for each month of the collected data years
SELECT 
    YEAR(incident_date) AS incident_year,
    MONTH(incident_date) AS incident_month,
    COUNT(*) AS incident_total,
    SUM(n_killed) AS total_killed,
    SUM(n_injured) AS total_injured
FROM clean_gun_violence
GROUP BY YEAR(incident_date), MONTH(incident_date)
ORDER BY incident_year, incident_month;

/* Classifying monthly incidents into harm severity tiers (low, medium, high, mass casualty) 
based on fatality and injury counts.*/
WITH severity_level AS ( 
SELECT 
	incident_id, 
	incident_date,
	incident_state,
	n_killed, 
	n_injured,	
CASE WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
	WHEN n_killed = 0 AND  n_injured BETWEEN 2 AND 3 THEN 'Medium'
	WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
	WHEN n_killed >= 3 THEN 'Mass Casualty'
END AS severity_level
FROM clean_gun_violence
)
SELECT 
	YEAR(incident_date) AS incident_year,
	MONTH(incident_date) AS incident_month,
	severity_level, 
	COUNT(incident_id) AS incident_total
FROM severity_level
GROUP BY YEAR(incident_date), MONTH(incident_date), severity_level
ORDER BY incident_year, incident_month, 
	CASE severity_level
		WHEN 'Low' Then 1
		WHEN 'Medium' THEN 2
		WHEN 'High' THEN 3
		WHEN 'Mass Casualty' THEN 4
	END;

-- Incident total by state: The number of incidents in each state ranked from highest to lowest. 
SELECT
    incident_state,
    COUNT (incident_id) AS incident_concentration
From clean_gun_violence
GROUP BY incident_state
ORDER BY incident_concentration DESC;

-- Incident total by state and year: The number of incidents in each state broken out by year.
SELECT
	incident_state,
	COUNT (incident_id) AS incident_concentration,
	YEAR (incident_date) AS Incidents_by_year
From clean_gun_violence
GROUP BY incident_state, YEAR (incident_date)
ORDER BY incident_state, Incidents_by_year;

/* Average severity by state: Classifying incidents into harm severity tiers  
(low, medium, high, mass casualty) based on fatality and injury counts */
WITH severity_level AS ( 
SELECT 
	incident_id, 
	incident_state,
	n_killed, 
	n_injured,	
CASE WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
	WHEN n_killed = 0 AND  n_injured BETWEEN 2 AND 3 THEN 'Medium'
	WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
	WHEN n_killed >= 3 THEN 'Mass Casualty'
END AS severity_level
FROM clean_gun_violence
)
SELECT
    incident_state,
	severity_level,
	COUNT (incident_id) AS incident_concentration 
FROM severity_level
GROUP BY incident_state, severity_level
ORDER BY incident_state, 
	CASE severity_level
		WHEN 'Low' Then 1
		WHEN 'Medium' THEN 2
		WHEN 'High' THEN 3
		WHEN 'Mass Casualty' THEN 4
	END;

-- Average severity by state: How deadly incidents are on average. 
WITH severity_level AS ( 
SELECT 
	incident_id, 
	incident_state,
	n_killed, 
	n_injured,	
CASE WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
	WHEN n_killed = 0 AND  n_injured BETWEEN 2 AND 3 THEN 'Medium'
	WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
	WHEN n_killed >= 3 THEN 'Mass Casualty'
END AS severity_level
FROM clean_gun_violence
)
SELECT
    incident_state,
	AVG(CAST(n_killed AS DECIMAL(10,2))) AS avg_killed,
	AVG(CAST(n_injured AS DECIMAL(10,2))) AS avg_injured,
	AVG(CAST(n_killed + n_injured AS DECIMAL(10,2))) AS avg_casualties
FROM severity_level
GROUP BY incident_state
ORDER BY avg_casualties;

/*Geographic clustering of high-severity incidents: Identifying which states have the 
highest concentration of High and Mass Casualty incidents.*/
WITH severity_level AS ( 
SELECT 
	incident_id, 
	incident_state,
	n_killed, 
	n_injured,	
CASE WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
	WHEN n_killed = 0 AND  n_injured BETWEEN 2 AND 3 THEN 'Medium'
	WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
	WHEN n_killed >= 3 THEN 'Mass Casualty'
END AS severity_level
FROM clean_gun_violence
)
SELECT
    incident_state,
	severity_level,
	COUNT (incident_id) as incident_total
FROM severity_level
WHERE severity_level IN ('High', 'Mass Casualty')
GROUP BY incident_state, severity_level
ORDER BY 
    CASE severity_level
        WHEN 'High' THEN 1
        WHEN 'Mass Casualty' THEN 2
    END,
    incident_total DESC;

-- Splitting pipe-delimited incident_characteristics to identify individual incident types
SELECT 
    value AS incident_type,
    COUNT(*) AS incident_total
FROM clean_gun_violence
CROSS APPLY STRING_SPLIT(incident_characteristics, '|')
WHERE value != ''
GROUP BY value
ORDER BY incident_total DESC;

/* Incident type by severity tier: Identifying which incident types are most  
associated with high-severity and mass casualty outcomes.*/
WITH severity_level AS ( 
SELECT 
	incident_id, 
	incident_state,
	n_killed, 
	n_injured,	
	incident_characteristics,
CASE WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
	WHEN n_killed = 0 AND  n_injured BETWEEN 2 AND 3 THEN 'Medium'
	WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
	WHEN n_killed >= 3 THEN 'Mass Casualty'
END AS severity_level
FROM clean_gun_violence
) 
SELECT 
    value AS incident_type,
    COUNT(*) AS incident_total,
	severity_level
FROM severity_level
CROSS APPLY STRING_SPLIT(incident_characteristics, '|')
WHERE value != ''
GROUP BY value, severity_level
ORDER BY incident_type, 
    CASE severity_level
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
        WHEN 'Mass Casualty' THEN 4
    END;

--Which combinations of factors show up most often when an incident turns into a Mass Casualty event?
WITH severity_level AS ( 
SELECT 
	incident_id, 
	incident_state,
	n_killed, 
	n_injured,
	incident_date,
	incident_characteristics,
CASE WHEN n_killed = 0 AND n_injured <= 1 THEN 'Low'
	WHEN n_killed = 0 AND  n_injured BETWEEN 2 AND 3 THEN 'Medium'
	WHEN n_killed BETWEEN 1 AND 2 OR n_injured >= 4 THEN 'High'
	WHEN n_killed >= 3 THEN 'Mass Casualty'
END AS severity_level
FROM clean_gun_violence
)
SELECT 
	incident_state,
	MONTH (incident_date) AS incident_month,
	value AS incident_type,
	COUNT(*) AS incident_total
FROM severity_level
CROSS APPLY STRING_SPLIT(incident_characteristics, '|')
WHERE value != '' and severity_level = 'Mass Casualty'
GROUP BY incident_state, MONTH(incident_date), value;
