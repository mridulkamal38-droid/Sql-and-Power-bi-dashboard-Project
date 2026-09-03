# Sql and Power bi dashboard Project
# ☕ Museum Coffee Shop Chain — Analytics Dashboard

A portfolio data analytics project built on a fictional 5-shop coffee chain dataset, covering SQL view design and a 2-page Power BI dashboard for workforce and supplier insights.

## 📊 Overview

This project analyzes employee and supplier data across a coffee shop chain operating in **Los Angeles, New York, and London**. It demonstrates the full analytics pipeline: relational schema design → SQL Server views → Power BI dashboard with DAX measures.

**Live artifacts:**
- `sql_employee_report_museum.sql` — SQL Server view joining employees, shops, and locations
- `sql_supplier_report_museum.sql` — SQL Server view joining suppliers, shops, and locations
- `Museum_DashBoard_Report.pbix` — 2-page Power BI dashboard (Employees, Shops)

## 🗂️ Dataset & Schema

Four related tables:

| Table | Description |
|---|---|
| `employees` | ~1,000 employee records — name, email, hire date, gender, salary, assigned shop |
| `shops` | 5 coffee shops, each linked to a city |
| `locations` | City and country reference table |
| `suppliers` | Shop-to-supplier relationships with coffee type sourced |

Relationships use foreign keys with `ON DELETE SET NULL` (employees→shops, shops→locations) and `ON DELETE CASCADE` (suppliers→shops).

## 🛠️ SQL Views

### `Employee_report`
Built with layered CTEs to progressively enrich employee data:
- Concatenates first/last name into `full_name`
- Calculates tenure (`total_year_work`) from hire date
- Buckets employees into tenure classifications: **New, Established, Experienced, Long-term, Legacy**
- Buckets salary into: **Low, Below Average, Average, Above Average, High**
- Handles missing emails with `COALESCE(email, 'Not Available')`
- Left-joined to shops and locations to preserve unassigned employees

### `supplier_report`
Flat denormalized view joining suppliers → shops → locations for easy filtering by coffee type, shop, city, and country.

## 📈 Dashboard Pages

### Page 1 — Employees
- **KPIs:** Total Employees, Avg Salary, Avg Tenure, Email Submit Rate
- Employee count by shop (bar chart)
- Gender split (donut)
- Employee classification by city (100% stacked bar)

### Page 2 — Shops & Suppliers
- **KPIs:** Total Suppliers, Total Coffee Types, Total Shops, Low Supplier Diversity
- Shops × coffee type sourcing matrix
- Supplier count per shop (donut)
- Coffee shop count by city (bar)
- Coffee type distribution (donut)

## ⚠️ Known Limitations

- `DATEDIFF(year, hire_date, GETDATE())` in `Employee_report` measures calendar-year boundaries crossed rather than full elapsed years, which can under/overstate tenure by up to a year near year-end hire dates. Flagged for a future fix using a month/day-aware adjustment.
- The "Low Supplier Diversity" KPI counts shops with 2 or fewer suppliers rather than exactly one, since no shop in this dataset has a single supplier — the threshold was chosen to keep the metric meaningful against real data rather than always reading zero.

## 🧰 Tech Stack

- SQL Server (T-SQL, views, CTEs)
- Power BI (DAX, Power Query, data modeling)

## 👤 Author

**Mridul Kamal**
- Portfolio: [mridulkamal.netlify.app](https://mridulkamal.netlify.app)
- GitHub: [github.com/mridulkamal38-droid](https://github.com/mridulkamal38-droid)
