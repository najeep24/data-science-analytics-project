/*
===============================================================================
Database Exploration & Business Metrics Report
===============================================================================
Purpose:
    - To explore the structure and key contents of the data warehouse.
    - To inspect metadata (tables and columns) for understanding database schema.
    - To explore dimension tables (customers, products) for unique attribute values.
    - To analyze key temporal attributes in sales data (first & last order date).
    - To profile customer demographics (youngest and oldest customers).
    - To generate a consolidated report of key business performance metrics.

Tables Used:
    - INFORMATION_SCHEMA.TABLES          → Retrieve list of all tables in the database
    - INFORMATION_SCHEMA.COLUMNS         → Inspect schema of specific tables
    - gold.dim_customers                 → Explore customer countries & demographics
    - gold.dim_products                  → Explore product categories, subcategories, and names
    - gold.fact_sales                    → Analyze order date range and compute key sales KPIs

Metrics Generated:
    - Unique Countries
    - Unique Categories, Subcategories, Products
    - First & Last Order Date + Range (in months)
    - Youngest & Oldest Customer Birthdate and Age
    - Total Sales, Total Quantity, Average Price, Total Orders, Total Products, Total Customers
===============================================================================
*/


-- Retrieve a list of all tables in the database
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;


-- Retrieve all columns for a specific table (dim_customers)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';


-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;


-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;


-- Determine the first and last order date and the total duration in months
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;


-- Find the youngest and oldest customer based on birthdate
SELECT
    MIN(birthdate) AS oldest_birthdate,
    DATEDIFF(YEAR, MIN(birthdate), GETDATE()) AS oldest_age,
    MAX(birthdate) AS youngest_birthdate,
    DATEDIFF(YEAR, MAX(birthdate), GETDATE()) AS youngest_age
FROM gold.dim_customers;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;
