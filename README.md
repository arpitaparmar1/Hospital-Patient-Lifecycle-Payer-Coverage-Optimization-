📊 Hospital-Patient-Lifecycle-Payer-Coverage-Optimization-

This project transforms fragmented healthcare clinical records into a high-performance relational database to drive hospital operational efficiency. By engineering an automated ETL pipeline and interactive BI dashboard, this study identifies key trends in patient readmission rates, payer coverage gaps, and departmental cost distributions.

🛠️ Tech Stack

Data Cleaning & ETL: Python (Pandas, NumPy)

Database Management: PostgreSQL

Data Analysis: SQL (Window Functions, CTEs, Joins)

Visualization: Power BI

Documentation: Microsoft PowerPoint (Executive Summary)'

📁 Repository Structure

File,Description

data_cleaning.py:
"Python script for standardizing date-times, handling nulls, and text normalization."

sql_query.sql:
Advanced SQL scripts for schema creation and KPI calculations.

hospital_analytics_questions:
.sql,Business-logic queries addressing specific clinical and financial objectives.

Hospital patient Record Dashboard:
pbix,Interactive Power BI dashboard file.

Hospital Patient Lifecycle Study.pptx:
Professional presentation of findings and technical architecture.

🚀 Key Features & Analysis

1. Data Engineering (ETL)
Temporal Normalization: Automated the conversion of non-standard "Start/Stop" strings into standardized SQL-ready datetime objects.

Schema Design: Engineered a robust relational schema with primary and foreign key constraints across Patients, Encounters, Payers, and Procedures.

2. Clinical Quality Metrics
30-Day Readmission Tracking: Developed a sophisticated SQL tracking system using LAG() window functions to identify patients returning within 30 days—a critical metric for hospital care quality.
   
Temporal Trends: Analyzed patient admission volume by quarter to assist in staffing resource allocation.

4. Financial Optimization
Payer Coverage Analysis: Identified encounters with zero payer coverage to highlight financial risk zones.

Cost Benchmarking: Ranked the most frequent vs. most expensive procedures to optimize revenue cycle management.


📈 Dashboard Insights

The Power BI dashboard provides an executive view of:

Patient Outcomes: Visualization of readmission rates and encounter classes (Emergency vs. Wellness).

Financial Health: Average claim costs broken down by payer name and procedure description.

💡 How to Run This Project

Clean the Data: Run the data_cleaning.py script to process the raw CSV files.

Setup Database: Execute the sql_query.sql in your PostgreSQL environment to build the tables and constraints.

Run Analytics: Use hospital_analytics_questions.sql to generate the core business insights.

Visualize: Open the .pbix file in Power BI Desktop to explore the interactive report.

📫 Contact
Parmar Arpitaba

LinkedIn: (https://www.linkedin.com/in/arpita-parmar-b70476348/)

Email: arpitaparmar548@gmail.com

