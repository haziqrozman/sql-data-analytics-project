/*
================================================================================
Script      : 12_report_customers.sql
Purpose     : Creates a customer report view aggregating key metrics and
              segments for each customer.
Parameters  : None
Run         : SELECT * FROM gold.report_customers;
--------------------------------------------------------------------------------
WARNING     : This script drops and recreates the gold.report_customers view.
              Any downstream queries dependent on this view may be affected.
              Ensure dependencies are reviewed before executing.
================================================================================
*/

IF OBJECT_ID('gold.report_customers', 'V') IS NOT NULL
    DROP VIEW gold.report_customers;
GO

CREATE VIEW gold.report_customers AS
WITH base_query AS (
    SELECT
        s.order_number,
        s.product_key,
        s.order_date,
        s.sales_amount,
        s.quantity,
        c.customer_key,
        c.customer_number,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        DATEDIFF(YEAR, c.birthdate, GETDATE()) AS customer_age
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_customers AS c
    ON s.customer_key = c.customer_key
    WHERE s.order_date IS NOT NULL
),
customer_aggregation AS (
    SELECT
        customer_key,
        customer_number,
        customer_name,
        customer_age,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(sales_amount) AS total_sales,
        COUNT(DISTINCT product_key) AS total_products,
        SUM(quantity) AS total_quantity,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS last_order_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS customer_lifespan_months
    FROM base_query
    GROUP BY
        customer_key,
        customer_number,
        customer_name,
        customer_age
)
SELECT
    customer_key,
    customer_number,
    customer_name,
    customer_age,
    CASE
        WHEN total_sales > 5000 AND customer_lifespan_months >= 12 THEN 'VIP'
        WHEN total_sales <= 5000 AND customer_lifespan_months >= 12 THEN 'Regular'
        ELSE 'New'
    END AS customer_segment,
    total_orders,
    total_sales,
    total_products,
    total_quantity,
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS avg_order_value,
    first_order_date,
    last_order_date,
    customer_lifespan_months,
    DATEDIFF(MONTH, last_order_date, GETDATE()) AS months_since_last_order
FROM customer_aggregation;