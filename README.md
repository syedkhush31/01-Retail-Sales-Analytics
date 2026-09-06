📊 Retail Sales Analytics
End‑to‑end retail sales analytics project analyzing sales, profitability, customers, products, regions, and discount impact using SQL, Excel, and Power BI.

📌 Overview
Retail businesses need more than revenue numbers — they need to understand where profitability comes from, which products and regions perform best, and how discounting affects margins.

This project analyzes a multi‑year retail dataset (2014–2017) to uncover insights across:

Sales & profit performance

Year‑over‑year growth

Category & sub‑category trends

Regional profitability

Customer purchasing behavior

Product performance

Discount impact on profitability

Monthly & yearly sales trends

🎯 Business Objectives
Measure total sales, profit, orders, customers, and units sold

Identify profitable vs. loss‑making categories and regions

Analyze yearly and monthly performance trends

Evaluate discount–profitability relationships

Understand customer purchasing patterns

Identify top and bottom products and customers

Convert insights into actionable business recommendations

🛠️ Tools & Technologies
Tool	Purpose
MySQL / SQL	Data validation, business analysis, advanced SQL
Microsoft Excel	Exploratory analysis, pivot tables, calculations
Power BI	Interactive dashboard & executive reporting
Git / GitHub	Version control & documentation


📁 Dataset Summary
Retail Superstore transactional dataset containing:

9,994 transactions

21 columns

793 customers

5,009 orders

37,873 units sold

Period: Jan 2014 – Dec 2017

Key Fields:  
Order ID, Order Date, Ship Date, Ship Mode, Customer ID, Customer Name, Segment, Country, City, State, Postal Code, Region, Product ID, Category, Sub‑Category, Product Name, Sales, Quantity, Discount, Profit.

🔍 Data Quality Checks (SQL)
Validated using MySQL:

Row count

Row ID uniqueness

Duplicate checks

NULL value checks

Numeric value validation

Date range validation

Category, region, segment consistency

Ship mode consistency

Result:  
Dataset contains 9,994 clean records with no duplicate Row IDs or invalid numeric values.

📈 Key Business Metrics
Metric	Value
Total Sales	$2.30M
Total Profit	$286.40K
Total Orders	5,009
Total Customers	793
Units Sold	37,873
Profit Margin	12.47%
Average Order Value	$458.61
Analysis Period	2014–2017


📊 Power BI Dashboard
The dashboard provides an executive‑level view of retail performance.

Features:

Sales, Profit, Orders, Profit Margin KPIs

Annual Sales & Profit Trend

Monthly Sales Trend

Sales by Category

Profit by Region

Discount vs. Profit Analysis

Year filters

Key Insights panel

💡 Key Insights
1. Technology leads profitability
Profit: $145.45K

Margin: 17.40%  
Strongest category by profitability.

2. Furniture has the weakest margin
Profit: $18.45K

Margin: 2.49%  
High revenue but low profitability.

3. West is the strongest region
Sales: $725.46K

Profit: $108.42K

Margin: 14.94%

4. Central region has a profitability gap
Sales: $501.24K

Profit: $39.71K

Margin: 7.92%

5. Sales & profit increased over time
Year	Sales	Profit
2014	$484.25K	$49.54K
2015	$470.53K	$61.62K
2016	$609.21K	$81.80K
2017	$733.22K	$93.44K


6. Higher discounts = lower profitability
Discounts above 30% became loss‑making overall.

🧮 SQL Analysis
01_database_setup.sql
Database + table creation.

02_data_cleaning.sql
Data validation checks.

03_business_analysis.sql
Core business analysis:

KPIs

Profit margin

Yearly & monthly trends

Category & sub‑category performance

Regional & segment analysis

Discount impact

Top/bottom products

Customer profitability

Shipping mode performance

State‑level analysis

04_advanced_analysis.sql
Advanced SQL using:

CTEs

Window functions

Ranking

Running totals

YOY analysis

Profit contribution

Customer segmentation

High‑sales, low‑margin products

05_data_import.sql
CSV → MySQL import using LOAD DATA INFILE.

📊 Excel Analysis
Performed exploratory analysis:

Pivot tables

Category & region analysis

Yearly & monthly trends

Customer analysis

Profit margin calculations

File: excel/Retail_Sales_Analysis.xlsx

💼 Business Recommendations
Review Furniture pricing & cost structure

Optimize discount strategy

Invest further in Technology category

Investigate Central region performance

Monitor profit alongside revenue

📂 Project Structure
Code
01-Retail-Sales-Analytics/
│
├── data/
│   └── raw/
│       └── superstore.csv
│
├── documentation/
│   └── 01_dataset_overview.md
│
├── excel/
│   └── Retail_Sales_Analysis.xlsx
│
├── powerbi/
│   └── Retail_Sales_Analytics.pbix
│
├── screenshots/
│   ├── dashboard.png
│   └── executive_overview.png
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_business_analysis.sql
│   ├── 04_advanced_analysis.sql
│   └── 05_data_import.sql
│
└── README.md
🔄 Workflow
Raw Data →
Data Validation →
Excel Analysis →
MySQL Import →
SQL Business Analysis →
Advanced SQL →
Power BI Dashboard →
Insights →
Recommendations

👤 Author
Syed Khush  
Bachelor of Engineering – Computer Science

Skills: SQL | Excel | Power BI | Data Analytics
GitHub: syedkhush31

⭐ Project Highlights
9,994 transactions analyzed

5,009 orders

793 customers

37,873 units sold

$2.30M total sales

$286.40K total profit

12.47% profit margin

Business‑focused SQL analysis

Advanced SQL (CTEs, window functions)

Excel exploratory analysis

Interactive Power BI dashboard

Actionable business recommendations
