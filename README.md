# Gun Violence Incident Analysis: Severity Patterns and Escalation
## ✍️ Project Overview
This project analyzes 239,677 real gun violence incidents from the Gun Violence Archive (2013–2018) using SQL Server. The analysis focuses on incident-level severity classification, geographic and temporal trend detection, and identifying combinations of factors associated with mass-casualty escalation. Participant-level fields were excluded due to 41–93% null rates and invalid encoding; all findings are scoped to incident-level variables with complete or near-complete coverage.
## 🎯 Project Objectives
- **Classify** incidents into harm severity tiers (low, medium, high, mass casualty) based on fatality and injury counts to enable structured analysis across incident types.
- **Identify** year-over-year and seasonal trends in incident volume and average severity across the full 2013–2018 period.
- **Determine** which states and regions show the highest incident concentration and the highest average severity, and whether high-severity incidents cluster geographically.
- Parse and categorize incident characteristics to identify the most common incident types and their relationship to severity outcomes.
- **Identify** combinations of incident type, geography, and time most associated with mass-casualty escalation.
## 📊 Data Source & Scope
- **Source**: Gun Violence Archive (GVA) via Kaggle — 239,677 real incidents recorded across the United States, 2013–2018.
- **Data Quality**: Participant-level fields (participant_age, participant_gender, participant_relationship) were excluded due to 41–93% null rates and pipe-delimited encoding with no available validation source. All analysis operates on incident-level fields with complete or near-complete coverage.
- **Scope**: Incident-level analysis only. No participant-level disaggregation. No data outside the 2013–2018 date range.
- **Documentation**: Query logic and severity classification methodology are documented inline and in this README to support reproducibility and peer review.
