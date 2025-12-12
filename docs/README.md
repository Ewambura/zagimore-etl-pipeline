Author
------

Emmanuel Wambura  
M.S. Data Science | Data Analytics & Data Engineering



# Zagimore ETL Pipeline & Data Warehouse

## Project Overview
This project implements a full **ETL (Extract, Transform, Load) pipeline** and **data warehouse** for the Zagimore business domain.  
It demonstrates real-world data engineering practices including layered schemas, data staging, dimensional modeling, stored procedures, and repeatable refresh logic.

The pipeline moves data from operational source tables into a clean analytics-ready data warehouse using structured SQL scripts and controlled execution order.

---

## Architecture Overview

The ETL pipeline follows a standard **three-layer architecture**:

1. **Source Layer (OLTP)**
2. **Data Staging Layer**
3. **Data Warehouse Layer (Dimensional Model)**

Each layer is implemented as a separate database schema to enforce separation of concerns and improve maintainability.

---

## Database Schemas Used

| Layer | Schema Name |
|------|-----------|
| Source (OLTP) | `wamburej_F25_ZAGIMORE` |
| Data Staging | `wamburej_F25_ZAGIMORE_DS` |
| Data Warehouse | `wamburej_F25_ZAGIMORE_DW` |

---

## ETL Folder Structure

```text
sql/
 ├── 00_source_schema/          # Source tables (OLTP)
 ├── 10_datastaging_schema/     # Cleaned & prepared staging tables
 ├── 20_datawarehouse_schema/   # Dimension & fact tables
 ├── 30_procedures/             # Stored procedures (SCD, refresh logic)
 ├── 40_fact_refresh/           # Fact table population
 └── 90_validation_checks/      # Reconciliation & data quality checks

