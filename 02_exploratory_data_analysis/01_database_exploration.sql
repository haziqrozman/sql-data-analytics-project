/*
================================================================================
Script  : 01_database_exploration.sql
Purpose : Explores the structure of the database, including tables and columns.
================================================================================
*/

-- explore all tables in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- explore columns in dim_customers
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';

-- explore columns in dim_products
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_products';

-- explore columns in fact_sales
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_sales';