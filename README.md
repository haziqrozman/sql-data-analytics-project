# Exploratory and Advanced Data Analytics with SQL

## Project Overview

A structured SQL-based analytics project covering exploratory data analysis, advanced analytical techniques, and final business reports for business intelligence consumption using Microsoft SQL Server.

| **Detail** | **Description** |
|---|---|
| Database | Microsoft SQL Server |
| Tool | SQL Server Management Studio (SSMS) |
| Data Source | DataWarehouse database, Gold Layer — [sql-data-warehouse-project](https://github.com/haziqrozman/sql-data-warehouse-project) |
| Datasets | [View Datasets](https://github.com/haziqrozman/sql-data-analytics-project/tree/main/01_datasets) |

---

## Repository Structure

```
sql-data-analytics/
│
├── 01_datasets/                        # Source data — exported from sql-data-warehouse-project
│   ├── gold.dim_customers.csv
│   ├── gold.dim_products.csv
│   ├── gold.fact_sales.csv
│   └── 00_init_database.sql
│
├── 02_exploratory_data_analysis/       # EDA scripts — profiling and understanding the data
│   ├── 01_database_exploration.sql
│   ├── 02_dimensions_exploration.sql
│   ├── 03_date_range_exploration.sql
│   ├── 04_measures_exploration.sql
│   ├── 05_magnitude_analysis.sql
│   └── 06_ranking_analysis.sql
│
├── 03_advanced_data_analytics/         # ADA scripts — deeper analytical techniques
│   ├── 07_change_over_time_analysis.sql
│   ├── 08_cumulative_analysis.sql
│   ├── 09_performance_analysis.sql
│   ├── 10_data_segmentation.sql
│   └── 11_part_to_whole_analysis.sql
│
├── 04_reports/                         # Business report scripts
│   ├── 12_report_customers.sql
│   └── 13_report_products.sql
│
├── LICENSE
└── README.md
```

---

## Project Epics

### 0. Data Source
The analytics datasets are the Gold Layer tables from the `DataWarehouse` database, sourced from [sql-data-warehouse-project](https://github.com/haziqrozman/sql-data-warehouse-project) as the analytics-ready data source for this project.

- Initialise DataAnalytics Database & Load Gold Layer Datasets — [00_init_database.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/01_datasets/00_init_database.sql)

### 1. Exploratory Data Analysis (EDA)
Profiled and explored the dataset structure, dimensions, date ranges, and key measures to build a foundational understanding before any advanced analysis.

- Explore Database Structure — [01_database_exploration.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/02_exploratory_data_analysis/01_database_exploration.sql)
- Explore Dimension Values — [02_dimensions_exploration.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/02_exploratory_data_analysis/02_dimensions_exploration.sql)
- Explore Date Ranges — [03_date_range_exploration.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/02_exploratory_data_analysis/03_date_range_exploration.sql)
- Explore Key Measures — [04_measures_exploration.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/02_exploratory_data_analysis/04_measures_exploration.sql)
- Analyse Magnitude & Distribution — [05_magnitude_analysis.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/02_exploratory_data_analysis/05_magnitude_analysis.sql)
- Rank Top & Bottom Performers — [06_ranking_analysis.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/02_exploratory_data_analysis/06_ranking_analysis.sql)

### 2. Advanced Data Analytics (ADA)
Applied deeper analytical techniques to uncover trends, measure performance, and segment data for business insights.

- Analyse Change Over Time — [07_change_over_time_analysis.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/03_advanced_data_analytics/07_change_over_time_analysis.sql)
- Calculate Cumulative Metrics — [08_cumulative_analysis.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/03_advanced_data_analytics/08_cumulative_analysis.sql)
- Analyse Product Performance — [09_performance_analysis.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/03_advanced_data_analytics/09_performance_analysis.sql)
- Segment Data by Range — [10_data_segmentation.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/03_advanced_data_analytics/10_data_segmentation.sql)
- Analyse Part-to-Whole Contribution — [11_part_to_whole_analysis.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/03_advanced_data_analytics/11_part_to_whole_analysis.sql)

### 3. Business Reports
Built final analytical views consolidating all metrics, segments, and KPIs into structured customer and product reports for business consumption.

- Build Customer Report View — [12_report_customers.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/04_reports/12_report_customers.sql)
- Build Product Report View — [13_report_products.sql](https://github.com/haziqrozman/sql-data-analytics-project/blob/main/04_reports/13_report_products.sql)

---

## Project Technical Scope

- Database Exploration — inspected database objects and column metadata using `INFORMATION_SCHEMA` views
- Dimension Profiling — assessed categorical data variety using `SELECT DISTINCT`
- Date Range Analysis — determined temporal boundaries and age distributions using `MIN()`, `MAX()`, and `DATEDIFF()`
- Measures Exploration — computed aggregated business metrics using `SUM()`, `AVG()`, `COUNT()`, and `COUNT(DISTINCT)`, consolidated into a single summary using `UNION ALL`
- Magnitude Analysis — quantified measure scale across categorical dimensions using `GROUP BY` with `SUM()` and `COUNT()`
- Ranking Analysis — identified top and bottom performers using `TOP N` with `ORDER BY ASC/DESC`
- Change-Over-Time Trends — tracked measure evolution across time periods using `GROUP BY` with `YEAR()` and `MONTH()` date functions
- Cumulative Analysis — computed running totals and moving averages using `SUM() OVER (ORDER BY ...)` and `AVG() OVER (ORDER BY ...)` window functions
- Performance Analysis — benchmarked period performance against historical average and prior period using `AVG() OVER (PARTITION BY ...)` and `LAG()` with `CASE`-based flag classification
- Data Segmentation — classified records into defined tiers using `CASE` with boundary conditions across cost, spending, and lifespan dimensions
- Part-to-Whole Analysis — calculated proportional group contribution using `SUM() OVER()` with `CAST` for float division and `ROUND()` for formatted output
- Consolidated Business Reports — built analytical views using multi-CTE architecture combining base query joins, grouped aggregations, and `CASE`-based segmentation into reusable objects for business consumption

---

## Get in Touch

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/haziqrozman/)
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:haziqrozman99@gmail.com)
