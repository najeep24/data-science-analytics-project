# SQL Analytics Repository

A comprehensive collection of SQL analytics scripts for business intelligence, featuring exploratory data analysis, customer segmentation, product performance tracking, and time-series analysis.

## 📋 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [Analysis Scripts](#analysis-scripts)
  - [Magnitude Analysis](#magnitude-analysis)
  - [Change Over Time Analysis](#change-over-time-analysis)
  - [Cumulative Analysis](#cumulative-analysis)
  - [Performance Analysis](#performance-analysis)
  - [Data Segmentation](#data-segmentation)
  - [Part-to-Whole Analysis](#part-to-whole-analysis)
- [Report Views](#report-views)
  - [Customer Report](#customer-report)
  - [Product Report](#product-report)
- [Key Metrics & KPIs](#key-metrics--kpis)
- [SQL Functions Reference](#sql-functions-reference)
- [Getting Started](#getting-started)

---

## Overview

This repository contains SQL scripts designed for comprehensive business analytics on sales data. The scripts are built using **SQL Server (T-SQL)** and implement various analytical frameworks including magnitude analysis, temporal trends, customer segmentation, and performance benchmarking.

**Key Features:**
- 🔍 Multi-dimensional exploratory analysis
- 📊 Pre-built analytical views for products and customers
- 📈 Time-series and trend analysis
- 🎯 Customer and product segmentation
- 💡 KPI calculations (AOR, CLV, Recency, etc.)

---

## Project Structure

```
sql-analytics/
├── datasets/
├── docs/
├── scripts/
│   ├── exploration_database.sql
│   ├── magnitude_analysis.sql
│   ├── change_overtime_analysis.sql
│   ├── cumulative_analysis.sql
│   ├── performance_analysis.sql
│   ├── data_segmentation.sql
│   ├── part_to_whole_analysis.sql
│   ├── customer_report.sql
│   └── product_report.sql
└── README.md
```

---

## Analysis Scripts

### Magnitude Analysis
**File:** [`magnitude_analysis.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/02_magnitude_analysis.sql)

**Purpose:** Quantify data distributions and aggregate metrics across dimensions to understand scale and volume.

**Key Queries:**
- Customer distribution by country and gender
- Product counts by category
- Average costs per category
- Revenue aggregation by customer and category
- Geographic distribution of sales

**SQL Techniques:**
```sql
COUNT(), SUM(), AVG(), GROUP BY, ORDER BY
```

**Use Cases:**
- Understanding customer base composition
- Identifying high-revenue categories
- Geographic market analysis

---

### Change Over Time Analysis
**File:** [`change_overtime_analysis.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/03_change_overtime_analysis.sql)

**Purpose:** Track trends, seasonality, and temporal patterns in sales performance.

**Key Queries:**
- Monthly/yearly sales trends
- Customer acquisition over time
- Quantity sold trends

**SQL Techniques:**
```sql
YEAR(), MONTH(), DATETRUNC(), FORMAT()
Date aggregations with GROUP BY
```

**Use Cases:**
- Identifying seasonal patterns
- Tracking growth trajectories
- Forecasting future performance

---

### Cumulative Analysis
**File:** [`cumulative_analysis.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/04_cumulative_analysis.sql)

**Purpose:** Calculate running totals and cumulative metrics to understand progressive growth patterns.

**Key Queries:**
- Cumulative sales over time
- Running customer counts
- Progressive quantity trends

**SQL Techniques:**
```sql
SUM() OVER (ORDER BY date ROWS UNBOUNDED PRECEDING)
Window functions for running totals
```

**Use Cases:**
- Year-to-date (YTD) tracking
- Milestone achievement monitoring
- Growth rate analysis

---

### Performance Analysis
**File:** [`performance_analysis.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/05_performance_analysis.sql)

**Purpose:** Benchmark performance against historical periods and averages using Year-over-Year (YoY) and comparative metrics.

**Key Queries:**
- Year-over-Year product performance
- Sales comparison vs. product averages
- Trend identification (increase/decrease)

**SQL Techniques:**
```sql
LAG() OVER (PARTITION BY ... ORDER BY ...)
AVG() OVER (PARTITION BY ...)
CASE statements for trend classification
```

**Use Cases:**
- Identifying growth/decline patterns
- Comparing against benchmarks
- Performance scorecarding

---

### Data Segmentation
**File:** [`data_segmentation.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/06_data_segmentation.sql)

**Purpose:** Group data into meaningful segments for targeted analysis and personalized insights.

**Key Queries:**
- Product cost range segmentation
- Customer segmentation (VIP, Regular, New)
- Behavioral clustering

**SQL Techniques:**
```sql
CASE statements for custom logic
GROUP BY for aggregation
DATEDIFF() for lifespan calculation
```

**Segmentation Logic:**
- **VIP Customers:** Lifespan ≥ 12 months AND spending > €5,000
- **Regular Customers:** Lifespan ≥ 12 months AND spending ≤ €5,000
- **New Customers:** Lifespan < 12 months

**Use Cases:**
- Targeted marketing campaigns
- Customer retention strategies
- Product pricing analysis

---

### Part-to-Whole Analysis
**File:** [`part_to_whole_analysis.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/07_part_to_whole_analysis.sql)

**Purpose:** Understand contribution of individual components to the total, expressed as percentages.

**Key Queries:**
- Category contribution to total sales
- Percentage breakdown by dimension

**SQL Techniques:**
```sql
SUM() OVER () for total calculations
CAST() for precision in percentage calculations
Window functions for comparative analysis
```

**Use Cases:**
- Portfolio analysis
- Resource allocation decisions
- Market share evaluation

---

## Report Views

### Customer Report
**File:** [`customer_report.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/08_customer_report.sql)

**View Name:** `gold.report_customers`

**Purpose:** Consolidated customer intelligence view with behavioral metrics and segmentation.

**Key Metrics:**
| Metric | Description |
|--------|-------------|
| `total_orders` | Total number of orders placed |
| `total_sales` | Cumulative revenue generated |
| `total_quantity` | Total items purchased |
| `total_products` | Unique products purchased |
| `lifespan` | Months between first and last order |
| `recency` | Months since last order |
| `avg_order_value` | Average revenue per order |
| `avg_monthly_spend` | Average monthly spending rate |

**Segments:**
- **Age Groups:** Under 20, 20-29, 30-39, 40-49, 50+
- **Customer Tiers:** VIP, Regular, New

**Usage Example:**
```sql
SELECT 
    customer_name,
    customer_segment,
    total_sales,
    avg_order_value,
    recency
FROM gold.report_customers
WHERE customer_segment = 'VIP'
ORDER BY total_sales DESC;
```

---

### Product Report
**File:** [`product_report.sql`](https://github.com/najeep24/transaction-dataset-analytics-sql/blob/7a252a7d2f7993d0973477c2dec0a41e66b1d45f/scripts/09_products_report.sql)

**View Name:** `gold.report_products`

**Purpose:** Comprehensive product performance dashboard with revenue tracking and lifecycle metrics.

**Key Metrics:**
| Metric | Description |
|--------|-------------|
| `total_orders` | Number of orders containing this product |
| `total_sales` | Total revenue generated |
| `total_quantity` | Total units sold |
| `total_customers` | Unique customers who purchased |
| `lifespan` | Months between first and last sale |
| `recency_in_months` | Months since last sale |
| `avg_selling_price` | Average price per unit |
| `avg_order_revenue` | Average revenue per order |
| `avg_monthly_revenue` | Monthly revenue rate |

**Product Segments:**
- **High-Performer:** Total sales > €50,000
- **Mid-Range:** Total sales €10,000 - €50,000
- **Low-Performer:** Total sales < €10,000

**Usage Example:**
```sql
SELECT 
    product_name,
    category,
    product_segment,
    total_sales,
    avg_monthly_revenue
FROM gold.report_products
WHERE product_segment = 'High-Performer'
ORDER BY total_sales DESC;
```

---

## Key Metrics & KPIs

### Customer Metrics
- **Average Order Value (AOV):** `total_sales / total_orders`
- **Recency:** Months since last purchase (RFM analysis component)
- **Lifespan:** Customer tenure in months
- **Average Monthly Spend:** `total_sales / lifespan`

### Product Metrics
- **Average Order Revenue (AOR):** `total_sales / total_orders`
- **Average Monthly Revenue:** `total_sales / lifespan`
- **Average Selling Price:** `sales_amount / quantity`
- **Recency:** Months since last sale

---

## SQL Functions Reference

### Aggregate Functions
- `SUM()`, `COUNT()`, `AVG()` - Basic aggregations
- `COUNT(DISTINCT)` - Unique value counting

### Date Functions
- `YEAR()`, `MONTH()` - Extract date parts
- `DATETRUNC()` - Truncate to date precision
- `FORMAT()` - Custom date formatting
- `DATEDIFF()` - Calculate date differences
- `GETDATE()` - Current timestamp

### Window Functions
- `LAG()` - Access previous row values
- `SUM() OVER()` - Running totals
- `AVG() OVER()` - Moving averages
- `PARTITION BY` - Group window calculations

### Utility Functions
- `CASE` - Conditional logic
- `CAST()` / `CONVERT()` - Type conversion
- `NULLIF()` - Handle division by zero
- `CONCAT()` - String concatenation

---

## Getting Started

### Prerequisites
- SQL Server 2016+ (for `DATETRUNC` support)
- Access to database with schema: `gold.fact_sales`, `gold.dim_customers`, `gold.dim_products`

### Schema Requirements

**Expected Tables:**
```sql
gold.fact_sales (
    order_number,
    order_date,
    customer_key,
    product_key,
    sales_amount,
    quantity
)

gold.dim_customers (
    customer_key,
    customer_number,
    first_name,
    last_name,
    birthdate,
    gender,
    country
)

gold.dim_products (
    product_key,
    product_name,
    category,
    subcategory,
    cost
)
```

### Installation

1. **Create Report Views:**
```sql
-- Execute product report
sqlcmd -S your_server -d your_database -i product_report.sql

-- Execute customer report
sqlcmd -S your_server -d your_database -i customer_report.sql
```

2. **Run Exploratory Queries:**
Execute individual analysis scripts based on your analytical needs.

3. **Query the Views:**
```sql
-- Example: Get VIP customer analysis
SELECT * FROM gold.report_customers
WHERE customer_segment = 'VIP';

-- Example: Product performance dashboard
SELECT * FROM gold.report_products
WHERE product_segment = 'High-Performer';
```

---

## Contributing

Contributions are welcome! Please ensure:
- Code follows T-SQL best practices
- Comments explain complex logic
- Queries are optimized with appropriate indexes

---

## License

This project is licensed under the MIT License.
