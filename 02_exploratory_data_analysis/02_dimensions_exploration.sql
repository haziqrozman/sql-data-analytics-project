/*
================================================================================
Script  : 02_dimensions_exploration.sql
Purpose : Explores the distinct values of dimension columns across the gold schema.
================================================================================
*/

-- explore all customer countries
SELECT DISTINCT country
FROM gold.dim_customers;

-- explore all product categories, sub-categories, and product names
SELECT DISTINCT category, sub_category, product_name
FROM gold.dim_products
ORDER BY category, sub_category, product_name;