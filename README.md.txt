E-commerce Sales and Customer Behavior Analysis
Project Summary

This project presents an end-to-end e-commerce data analysis workflow based on online retail transaction data. The goal of the analysis was to identify sales trends, top-performing products, key customer groups, market performance, and cancellation patterns.

The project was completed using Excel, Power Query, Power Pivot, DAX, SQL Server, SSMS, and Power BI. The raw dataset was first cleaned and transformed in Power Query, then analyzed with Power Pivot and DAX measures. The cleaned dataset was also imported into SQL Server, where reusable SQL views were created for completed sales and cancelled orders. Finally, an interactive Power BI dashboard was built to visualize the key findings.

Tools Used
Excel
Power Query
Power Pivot
DAX
SQL Server
SQL Server Management Studio
Power BI
PowerPoint
Coolors color palette generator
Data Preparation

The original dataset contained online retail transactions, including invoice numbers, product descriptions, quantities, invoice dates, unit prices, customer IDs, and countries.

The main data preparation steps included:

setting correct data types,
removing rows without CustomerID,
creating an IsCancelled column,
calculating revenue with Quantity × UnitPrice,
creating date-related fields such as year, month, quarter, and hour,
preparing separate logic for completed sales and cancelled orders,
importing the cleaned data into SQL Server.

In SQL Server, I created reusable views to make the analysis cleaner and easier to maintain:

vw_completed_sales
vw_cancelled_orders

These views allowed me to avoid repeating the same filtering logic in every SQL query.

Dashboard Design

The final dashboard was created in Power BI and contains three main pages:

Executive Summary
This page gives a high-level overview of revenue, orders, customers, quantity sold, average order value, monthly trends, top countries, and top products.
Product & Customer Performance
This page focuses on product-level and customer-level performance. It compares product revenue and quantity sold, shows customer revenue contribution, and highlights the highest-value customers.
Cancellation Analysis
This page analyzes cancelled orders, cancellation rate, cancelled products, and monthly cancellation patterns.

The dashboard background design and visual layout elements were created in PowerPoint. The color palette was selected using Coolors: https://coolors.co/?home

Key Insights
The business generated £8.89M in total revenue from 18,532 completed orders.
Revenue increased toward the end of 2011, with November showing the strongest monthly performance.
The United Kingdom was the dominant market, contributing the majority of total revenue.
A relatively small group of customers contributed a significant share of total revenue. The highest-value customer was Customer 14646, with more than £280K in total revenue.
Product performance varied significantly. Some products generated high revenue through high volume, while others showed much lower revenue per unit.
The overall cancellation rate was 16.47%, which suggests that cancelled orders should be monitored closely.
Cancellation volume also increased in November, which may be connected to higher order activity during the peak sales period.
Business Recommendations
Strengthen seasonal marketing and stock planning before peak revenue months, especially before November.
Monitor the UK market closely, as it generates the majority of revenue and has the largest impact on overall business performance.
Develop VIP or loyalty campaigns for high-value customers to increase retention and repeat purchases.
Review products with high cancellation volumes to identify possible issues related to product descriptions, availability, quality, or customer expectations.
Analyze low revenue-per-unit products separately before promoting them, as high sales volume does not always mean strong revenue contribution.
Track cancellation rate monthly to identify whether cancellations increase during peak sales periods.
Project Outcome

This project demonstrates a complete data analytics workflow from raw data preparation to dashboard creation. It shows practical skills in data cleaning, data modelling, DAX measure creation, SQL querying, business analysis, and dashboard storytelling.

The final result is an interactive Power BI dashboard that can support business decisions related to sales performance, product strategy, customer retention, and cancellation monitoring.