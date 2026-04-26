/*
================================================================================
Script  : 05_magnitude_analysis.sql
Purpose : Explores the magnitude of key measures across dimensions to understand
          scale and distribution of the data.
================================================================================
*/

-- explore total customers by country
SELECT
    country,
    COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;

-- explore total customers by gender
SELECT
    gender,
    COUNT(customer_key) AS total_customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;

-- explore total products by category
SELECT
    category,
    COUNT(product_key) AS total_products
FROM gold.dim_products
GROUP BY category
ORDER BY total_products DESC;

-- explore average cost by category
SELECT
    category,
    AVG(cost) AS avg_cost
FROM gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC;

-- explore total revenue by category
SELECT
    p.category,
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
ON p.product_key = s.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;

-- explore total revenue by customer
SELECT
    c.customer_key,
    c.first_name,
    c.last_name,
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = s.customer_key
GROUP BY
    c.customer_key,
    c.first_name,
    c.last_name
ORDER BY total_revenue DESC;

-- explore total quantity sold by country
SELECT
    c.country,
    SUM(s.quantity) AS total_quantity_sold
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_customers AS c
ON c.customer_key = s.customer_key
GROUP BY c.country
ORDER BY total_quantity_sold DESC;