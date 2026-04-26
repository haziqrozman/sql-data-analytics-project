/*
================================================================================
Script  : 11_part_to_whole_analysis.sql
Purpose : Analyses the proportional contribution of categories to overall sales
          to identify the most impactful segments.
================================================================================
*/

-- analyse each category's contribution to total sales
WITH category_sales AS (
    SELECT
        p.category,
        SUM(s.sales_amount) AS total_sales
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_products AS p
    ON p.product_key = s.product_key
    GROUP BY p.category
)
SELECT
    category,
    total_sales,
    CONCAT(ROUND((CAST(total_sales AS FLOAT) / SUM(total_sales) OVER()) * 100, 2), '%') AS total_sales_percentage
FROM category_sales
ORDER BY total_sales DESC;