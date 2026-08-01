# Gun Violence Incident Analysis: Severity Patterns and Escalation
## ✍️ Project Overview
This project analyzes 239,677 real gun violence incidents from the Gun Violence Data (2013–2018) using SQL Server. The analysis focuses on incident-level severity classification, geographic and temporal trend detection, and identifying combinations of factors associated with mass-casualty escalation. Participant-level fields were excluded due to 41–93% null rates and invalid encoding; all findings are scoped to incident-level variables with complete or near-complete coverage.
## 🎯 Project Objectives
- **Classify** incidents into harm severity tiers (low, medium, high, mass casualty) based on fatality and injury counts to enable structured analysis across incident types.
- **Identify** year-over-year and seasonal trends in incident volume and average severity across the full 2013–2018 period.
- **Determine** which states and regions show the highest incident concentration and the highest average severity, and whether high-severity incidents cluster geographically.
- **Parse and categorize** incident characteristics to identify the most common incident types and their relationship to severity outcomes.
- **Identify** combinations of incident type, geography, and time most associated with mass-casualty escalation.
## 📊 Data Source & Scope
- **Source**: [Gun Violence Data via Kaggle](https://www.kaggle.com/datasets/jameslko/gun-violence-data) - 239,677 real incidents recorded across the United States, 2013–2018.
  - *Note:* The raw dataset is not included in this repository due to file size
- **Data Quality**: Participant-level fields (participant_age, participant_gender, participant_relationship) were excluded due to 41–93% null rates and pipe-delimited encoding with no available validation source. All analysis operates on incident-level fields with complete or near-complete coverage.
- **Scope**: Incident-level analysis only. No participant-level disaggregation. No data outside the 2013–2018 date range.
- **Documentation**: Query logic and severity classification methodology are documented inline and in this README to support reproducibility and peer review.
## 💡 Results & Key Findings
### Basic Analysis
- **239,351** gun violence incidents were recorded across the United States between 2013 and 2018.
- **53,805** incidents (22%) resulted in at least one fatality.
- **802** incidents met the FBI definition of a mass shooting (3+ killed), representing less than 1% of all incidents.
- Across all incidents, **60,428** people were killed and **118,203** were injured, for a total of **178,631** casualties.
- **Illinois, California, and Florida** recorded the highest incident concentrations, accounting for a disproportionate share of total volume. However, high incident count does not necessarily reflect high severity — geographic clustering analysis revealed more nuance at the state level.
### Severity Classification
- The majority of incidents were classified as **Low severity** (0 killed, 1 or fewer injured), consistent with the high volume of non-fatal incidents in the dataset.
- **High severity incidents** (1–2 killed or 4+ injured) accounted for roughly 20–25% of all incidents consistently across all months and years.
- **Mass Casualty incidents** (3+ killed) were rare but persistent - never zero in any month across the full dataset.
### Trend Analysis
- Incident volume increased year over year from 2014 to 2017, with 2013 data incomplete and 2018 data representing a partial year.
- **Summer months (June–August) consistently showed the highest incident volume and Mass Casualty counts** across all years, with July being the peak month in most years.
- **February was consistently the lowest volume month** every year.
### Geographic Analysis
- **Illinois had the highest incident concentration** (17,506) but also the highest average injuries per incident (0.77), suggesting a pattern of high-frequency, high-injury violence concentrated in urban areas.
- **Texas led all states in Mass Casualty incidents** (76), followed by California and Florida (64 each) - despite Texas ranking 4th in total incident volume.
- **Arizona had the highest average casualties per incident** (0.94), indicating disproportionately severe outcomes relative to incident volume.
- **District of Columbia** had 449 high-severity incidents but only 1 Mass Casualty - suggesting high-frequency serious violence that rarely escalates to fatal mass events.
### Incident Type & Escalation Indicators
- **Murder/Suicide** and **Domestic Violence** were the incident types most consistently associated with Mass Casualty outcomes.
- **Child Involved Incidents** produced 84 Mass Casualty outcomes - a disproportionately high escalation rate relative to total volume.
- **Spree Shootings** had a ~10% Mass Casualty rate (40 out of 398 total), the highest escalation rate of any incident type.
- **Assault weapon involvement** was associated with 16 Mass Casualty incidents, consistent with their role in high-fatality events.
## 📊 Dashboard
[View Gun Violence Incident Analysis 2013-2018 Dashboard](https://public.tableau.com/shared/8BF4MKT64?:display_count=n&:origin=viz_share_link)
