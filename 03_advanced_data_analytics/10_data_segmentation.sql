/*
================================================================================
Script  : 10_data_segmentation.sql
Purpose : Segments products and customers into meaningful groups to support
          targeted analysis and business decision-making.
================================================================================
*/

-- segment products by cost range and count products per segment
WITH product_segments AS (
    SELECT
        product_key,
        product_name,
        cost,
        CASE WHEN cost < 100 THEN 'Below 100'
             WHEN cost BETWEEN 100 AND 500 THEN '100-500'
             WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
             ELSE 'Above 1000'
        END AS cost_range
    FROM gold.dim_products
)
SELECT
    cost_range,
    COUNT(product_key) AS total_products
FROM product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

-- segment customers by spending behaviour and lifespan
-- VIP     : at least 12 months of history and spending more than 5000
-- Regular : at least 12 months of history and spending 5000 or less
-- New     : lifespan less than 12 months
WITH customer_spend AS (
    SELECT
        c.customer_key,
        SUM(s.sales_amount) AS total_sales,
        MIN(s.order_date) AS first_order_date,
        MAX(s.order_date) AS last_order_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS customer_lifespan_months
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_customers AS c
    ON s.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT
        customer_key,
        total_sales,
        customer_lifespan_months,
        CASE
            WHEN total_sales > 5000 AND customer_lifespan_months >= 12 THEN 'VIP'
            WHEN total_sales <= 5000 AND customer_lifespan_months >= 12 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spend
) AS t
GROUP BY customer_segment
ORDER BY total_customers DESC;