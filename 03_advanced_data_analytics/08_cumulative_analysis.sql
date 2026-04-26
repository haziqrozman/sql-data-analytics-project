/*
================================================================================
Script  : 08_cumulative_analysis.sql
Purpose : Calculates cumulative and moving metrics over time to track
          progressive growth and trends.
================================================================================
*/

-- calculate running total of sales and moving average price over time
SELECT
    order_year,
    order_month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY order_year, order_month) AS running_total_sales,
    AVG(avg_price) OVER (ORDER BY order_year, order_month) AS moving_average_price
FROM (
    SELECT
        YEAR(order_date) AS order_year,
        MONTH(order_date) AS order_month,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date), MONTH(order_date)
) AS t;