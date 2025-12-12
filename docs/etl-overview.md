# ETL Overview

This project implements a layered ETL architecture consisting of:

1. Source (OLTP)
2. Data Staging
3. Data Warehouse

## Source Layer
The source schema (`wamburej_F25_ZAGIMORE`) contains raw operational tables
for sales and rental transactions.

## Data Staging Layer
The staging schema (`wamburej_F25_ZAGIMORE_DS`) is used for:
- Unifying sales and rental transactions (IFT)
- Pre-aggregation helpers (LR, ETC)
- Temporary, reloadable transformation logic

## Data Warehouse Layer
The warehouse schema (`wamburej_F25_ZAGIMORE_DW`) contains:
- Conformed dimensions
- RevenueFact
- Daily_Store_Snapshot with Type-2 tracking
