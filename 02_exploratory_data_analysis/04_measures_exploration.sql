/*
================================================================================
Script  : 04_measures_exploration.sql
Purpose : Explores the key business measures and metrics across the gold schema.
================================================================================
*/

-- explore total sales
SELECT SUM(sales_amount) AS total_sales
FROM gold.fact_sales;

-- explore total items sold
SELECT SUM(quantity) AS total_quantity
FROM gold.fact_sales;

-- explore average selling price
SELECT AVG(price) AS avg_price
FROM gold.fact_sales;

-- explore total number of orders
SELECT COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

-- explore total number of products
SELECT COUNT(product_key) AS total_products
FROM gold.dim_products;

-- explore total number of customers
SELECT COUNT(customer_key) AS total_customers
FROM gold.dim_customers;

-- explore total number of customers who placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers
FROM gold.fact_sales;

-- generate a summary report of key business metrics
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Average Price' AS measure_name, AVG(price) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Products' AS measure_name, COUNT(product_key) AS measure_value FROM gold.dim_products
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM gold.dim_customers;