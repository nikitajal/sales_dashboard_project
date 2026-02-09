# Sales & Revenue Dashboard

## Description
A dashboard showing sales performance using SQL, Python, and Tableau. Tracks total revenue, orders, average order value, top products, and daily revenue trends.

## Technologies
- SQL (MySQL): Schema design, data insertion, and analytical queries
- Python: Export data to CSV for Tableau
- Tableau: Dashboard visualization

## Folder Structure

sales_dashboard_project/
│
├── sql/
│   ├── schema.sql
│   ├── insert_data.sql
│   └── analysis_queries.sql
│
├── python/
│   └── export_data.py
│
├── data/
│   └── sales_analysis_clean.csv
│
├── tableau/
│   └── dashboard.twb
│
├── screenshots/
│   ├── dashboard_overview.png
│   ├── KPI_section.png
│   └── revenue_by_category.png
│
└── README.md


## How to Run
1. Execute `schema.sql` in MySQL
2. Execute `insert_data.sql` in MySQL
3. Run `export_data.py` → exports cleaned sales data to CSV
4. Open `dashboard.twb` in Tableau


## 📊 Key Insights

- Total Orders and Total Revenue provide a quick overview of sales performance.
- Electronics category contributes the highest revenue.
- Daily revenue trend shows how sales fluctuate over time.
- Repeat customers indicate potential customer retention and loyalty.

## 📸 Dashboard Screenshots

### Dashboard Overview
![Dashboard Overview](screenshots/dashboard_overview.png)

### Key KPIs
![KPIs](screenshots/KPI_section.png)

### Revenue by Category
![Revenue by Category](screenshots/revenue_by_category.png)

