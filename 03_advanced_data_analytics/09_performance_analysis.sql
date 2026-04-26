/*
================================================================================
Script  : 09_performance_analysis.sql
Purpose : Analyses yearly product performance by comparing sales against
          average sales and the previous year's sales.
================================================================================
*/

-- analyse yearly product performance against average and previous year sales
WITH yearly_product_sales AS (
    SELECT
        YEAR(s.order_date) AS order_year,
        p.product_name,
        SUM(s.sales_amount) AS total_sales
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_products AS p
    ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
    GROUP BY YEAR(s.order_date), p.product_name
)
SELECT
    order_year,
    product_name,
    total_sales,
    AVG(total_sales) OVER (PARTITION BY product_name) AS avg_sales,
    total_sales - AVG(total_sales) OVER (PARTITION BY product_name) AS avg_diff,
    CASE WHEN total_sales - AVG(total_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above avg'
         WHEN total_sales - AVG(total_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below avg'
         ELSE 'Avg'
    END AS avg_flag,
    LAG(total_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_year_sales,
    total_sales - LAG(total_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS prev_year_diff,
    CASE WHEN total_sales - LAG(total_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
         WHEN total_sales - LAG(total_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
         ELSE 'No change'
    END AS prev_year_flag
FROM yearly_product_sales
ORDER BY product_name, order_year;