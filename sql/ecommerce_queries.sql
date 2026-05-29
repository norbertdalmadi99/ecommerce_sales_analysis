-- DB and table creation
CREATE DATABASE ecommerce_portfolio;

CREATE TABLE online_retail_clean (
    InvoiceNo NVARCHAR(50),
    StockCode NVARCHAR(50),
    [Description] NVARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME2,
    UnitPrice DECIMAL(18, 4),
    CustomerID NVARCHAR(50),
    Country NVARCHAR(100),
    IsCancelled NVARCHAR(10),
    Revenue DECIMAL(18, 4),
    [Date] DATE,
    [Year] INT,
    [Month] INT,
    [Month Name] NVARCHAR(20),
    [Day Name] NVARCHAR(20),
    [Hour] INT
);

-- E-commerce Sales and Customer Behavior Analysis
-- SQL Server queries

USE ecommerce_portfolio;

-- Create reusable view for completed and cancelled sales
CREATE VIEW vw_completed_sales AS
SELECT *
FROM clean_online_retail
WHERE IsCancelled = 'FALSE'
  AND Quantity > 0
  AND UnitPrice > 0;

CREATE VIEW vw_cancelled_orders AS
SELECT *
FROM clean_online_retail
WHERE IsCancelled = 'TRUE';


-- 1. Total Revenue
SELECT 
    SUM(Revenue) AS total_revenue
FROM vw_completed_sales;

-- 2. Total Orders
SELECT 
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM vw_completed_sales;

-- 3. Total Customers
SELECT 
    COUNT(DISTINCT CustomerID) AS total_customers
FROM vw_completed_sales
WHERE CustomerID IS NOT NULL;

-- 4. Average Order Value
SELECT 
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT InvoiceNo), 
        2
    ) AS average_order_value
FROM vw_completed_sales;

-- 5. Monthly Revenue
SELECT
    FORMAT(InvoiceDate, 'yyyy-MM') AS year_month,
    ROUND(SUM(Revenue), 2) AS monthly_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM vw_completed_sales
GROUP BY FORMAT(InvoiceDate, 'yyyy-MM')
ORDER BY year_month;

-- 6. Top 10 Products by Revenue
SELECT TOP 10
    [Description],
    ROUND(SUM(Revenue), 2) AS revenue,
    SUM(Quantity) AS quantity_sold,
    COUNT(DISTINCT InvoiceNo) AS order_count
FROM vw_completed_sales
GROUP BY [Description]
ORDER BY revenue DESC;

-- 7. Top 10 Countries by Revenue
SELECT TOP 10
    Country,
    ROUND(SUM(Revenue), 2) AS revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    COUNT(DISTINCT CustomerID) AS total_customers
FROM vw_completed_sales
GROUP BY Country
ORDER BY revenue DESC;

-- 8. Top 10 Customers by Revenue
SELECT TOP 10
    CustomerID,
    ROUND(SUM(Revenue), 2) AS total_spent,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    ROUND(
        SUM(Revenue) / COUNT(DISTINCT InvoiceNo),
        2
    ) AS average_order_value
FROM vw_completed_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY total_spent DESC;

-- 9. Cancelled Orders
SELECT
    COUNT(DISTINCT InvoiceNo) AS cancelled_orders
FROM clean_online_retail
WHERE IsCancelled = 'TRUE';

-- 10. Cancellation Rate
SELECT
    CAST(cancelled_orders AS FLOAT) 
    / NULLIF(CAST(total_orders + cancelled_orders AS FLOAT), 0) AS cancellation_rate
FROM (
    SELECT
        COUNT(DISTINCT CASE 
            WHEN IsCancelled = 'FALSE'
             AND Quantity > 0 
             AND UnitPrice > 0 
            THEN InvoiceNo 
        END) AS total_orders,

        COUNT(DISTINCT CASE 
            WHEN IsCancelled = 'TRUE'
            THEN InvoiceNo 
        END) AS cancelled_orders
    FROM clean_online_retail
) AS summary;

-- 11. Low-Performing Months
SELECT
    FORMAT(InvoiceDate, 'yyyy-MM') AS year_month,
    ROUND(SUM(Revenue), 2) AS monthly_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM vw_completed_sales
GROUP BY FORMAT(InvoiceDate, 'yyyy-MM')
ORDER BY monthly_revenue ASC;

-- 12. Underperforming Products
SELECT TOP 10
    [Description],
    ROUND(SUM(Revenue), 2) AS revenue,
    SUM(Quantity) AS quantity_sold,
    COUNT(DISTINCT InvoiceNo) AS order_count
FROM vw_completed_sales
GROUP BY [Description]
HAVING COUNT(DISTINCT InvoiceNo) >= 5
ORDER BY revenue ASC;

SELECT *
FROM vw_completed_sales;