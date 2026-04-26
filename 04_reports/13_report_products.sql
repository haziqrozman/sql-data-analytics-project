/*
================================================================================
Script      : 13_report_products.sql
Purpose     : Creates a product report view aggregating key metrics and
              performance segments for each product.
Parameters  : None
Run         : SELECT * FROM gold.report_products;
--------------------------------------------------------------------------------
WARNING     : This script drops and recreates the gold.report_products view.
              Any downstream queries dependent on this view may be affected.
              Ensure dependencies are reviewed before executing.
================================================================================
*/

IF OBJECT_ID('gold.report_products', 'V') IS NOT NULL
    DROP VIEW gold.report_products;
GO

CREATE VIEW gold.report_products AS
WITH base_query AS (
    SELECT
        s.order_number,
        s.product_key,
        s.customer_key,
        s.order_date,
        s.sales_amount,
        s.quantity,
        p.product_number,
        p.product_name,
        p.category,
        p.sub_category,
        p.cost
    FROM gold.fact_sales AS s
    LEFT JOIN gold.dim_products AS p
    ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
),
product_aggregation AS (
    SELECT
        product_number,
        product_name,
        category,
        sub_category,
        cost AS product_cost,
        SUM(sales_amount) AS total_sales,
        COUNT(DISTINCT order_number) AS total_orders,
        SUM(quantity) AS total_quantity,
        COUNT(DISTINCT customer_key) AS total_customers,
        MIN(order_date) AS first_sale_date,
        MAX(order_date) AS last_sale_date,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS product_lifespan_months
    FROM base_query
    GROUP BY
        product_number,
        product_name,
        category,
        sub_category,
        cost
)
SELECT
    product_number,
    product_name,
    category,
    sub_category,
    CASE
        WHEN total_sales > 50000 THEN 'High'
        WHEN total_sales BETWEEN 10000 AND 50000 THEN 'Mid'
        ELSE 'Low'
    END AS product_performance,
    product_cost,
    total_sales,
    total_orders,
    total_quantity,
    total_customers,
    CASE
        WHEN total_orders = 0 THEN 0
        ELSE total_sales / total_orders
    END AS average_order_revenue,
    CASE
        WHEN product_lifespan_months = 0 THEN total_sales
        ELSE total_sales / product_lifespan_months
    END AS average_monthly_revenue,
    first_sale_date,
    last_sale_date,
    product_lifespan_months,
    DATEDIFF(MONTH, last_sale_date, GETDATE()) AS months_since_last_order
FROM product_aggregation;