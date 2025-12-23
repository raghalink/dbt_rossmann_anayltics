# ETL Run Log – dbt rossmann analytical pipeline (Pre-dbt)

This document records executed ETL runs for the Rossmann analytical pipeline prior to dbt modeling.  
All steps listed below were executed successfully and validated.

---

## ▶ Run 1 — Initial Load to PostgreSQL
**Date:** 2025-12-22 
**Database:** rossmann
**Schema:** raw
**Source:** [kaggle rossmann dataset].(https://www.kaggle.com/competitions/rossmann-store-sales/data)

---

### 1️⃣ Extraction
- Raw CSV files loaded from `data_raw/`
  - `train.csv` → sales data
  - `store.csv` → store master data

---

### 2️⃣ Transformation & Validation (Python / Pandas)

Performed in `02_clean_transform.ipynb`.

#### Sales (`train.csv`)
- Parsed `Date` column with strict format validation
- Normalized `StateHoliday` values while preserving original semantics
- Validated `DayOfWeek` against derived weekday from `Date`, then dropped column
- Enforced stable dtypes using nullable integers (`Int64`)
- Performed data quality checks:
  - `Open = 0` with `Sales > 0`
  - Duplicate composite keys `(Store, Date)`

#### Stores (`store.csv`)
- Enforced unique `Store` identifiers
- Cast categorical fields (`StoreType`, `Assortment`, `PromoInterval`) as strings
- Applied safe numeric casting to nullable integer columns
- Validated categorical value domains
- Checked Promo2 / PromoInterval consistency

#### Outputs
- Cleaned datasets exported locally (not tracked in git):
  - `data_clean/sales_clean.csv`
  - `data_clean/stores_clean.csv`

---

### 3️⃣ Load to PostgreSQL

Performed in `03_load_postgre.ipynb`.

- Loaded cleaned CSVs into PostgreSQL using SQLAlchemy engine
- Tables written with `if_exists="replace"` to ensure idempotent development runs
- Chunked inserts for performance and reliability

**Target tables:**
- `raw.sales_raw`
- `raw.stores_raw`

---

### 4️⃣ Post-Load Validation

Row counts verified after load:

| Table       | Rows Loaded |
|------------|-------------|
| sales_raw  | 1,017,209   |
| stores_raw | 1,115       |

---

### 5️⃣ Notes
- Cleaned CSV outputs are intentionally excluded from version control
- This run represents the **final pre-dbt ingestion state**
- dbt models will consume data from the `raw` schema in subsequent versions
