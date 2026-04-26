/*
================================================================================
Script  : 06_ranking_analysis.sql
Purpose : Ranks products and customers by key measures to identify top and
          bottom performers.
================================================================================
*/

-- top 5 products by total revenue
SELECT TOP 5
    p.product_name,
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- bottom 5 products by total revenue
SELECT TOP 5
    p.product_name,
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales AS s
LEFT JOIN gold.dim_products AS p
ON p.product_key = s.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;

-- top 10 customers by total revenue
SELECT TOP 10
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