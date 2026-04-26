/*
================================================================================
Script  : 00_init_database.sql
Purpose : Creates the 'DataAnalytics' database, gold schema, and loads
          dimension and fact tables from CSV source files.
--------------------------------------------------------------------------------
WARNING : This script drops and recreates 'DataAnalytics'. All existing data
          will be permanently lost. Ensure backups exist before executing.
================================================================================
*/

USE master;
GO

-- Drop and recreate the 'DataAnalytics' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataAnalytics')
BEGIN
    ALTER DATABASE DataAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataAnalytics;
END;
GO

-- Create the 'DataAnalytics' database
CREATE DATABASE DataAnalytics;
GO

USE DataAnalytics;
GO

-- Create schema
CREATE SCHEMA gold;
GO

-- Create dimension and fact tables
CREATE TABLE gold.dim_customers(
	customer_key INT,
	customer_id INT,
	customer_number NVARCHAR(50),
	first_name NVARCHAR(50),
	last_name NVARCHAR(50),
	country NVARCHAR(50),
	marital_status NVARCHAR(50),
	gender NVARCHAR(50),
	birthdate DATE,
	create_date DATE
);
GO

CREATE TABLE gold.dim_products(
	product_key INT,
	product_id INT,
	product_number NVARCHAR(50),
	product_name NVARCHAR(50),
	category_id NVARCHAR(50),
	category NVARCHAR(50),
	sub_category NVARCHAR(50),
	product_line NVARCHAR(50),
	maintenance NVARCHAR(50),
	cost INT,
	start_date DATE
);
GO

CREATE TABLE gold.fact_sales(
	order_number NVARCHAR(50),
	product_key INT,
	customer_key INT,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	price INT,
	quantity TINYINT,
	sales_amount INT
);
GO

-- Load gold.dim_customers
TRUNCATE TABLE gold.dim_customers;
GO
BULK INSERT gold.dim_customers
FROM 'C:\Users\User\sql-data-analytics-project\01_datasets\gold.dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- Load gold.dim_products
TRUNCATE TABLE gold.dim_products;
GO
BULK INSERT gold.dim_products
FROM 'C:\Users\User\sql-data-analytics-project\01_datasets\gold.dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- Load gold.fact_sales
TRUNCATE TABLE gold.fact_sales;
GO
BULK INSERT gold.fact_sales
FROM 'C:\Users\User\sql-data-analytics-project\01_datasets\gold.fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO