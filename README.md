# Rossmann Analytics Engineering Project 🚀

**End‑to‑end analytics project** demonstrating analytics engineering principles and business-focused reporting.The project demonstrates a production‑style analytics workflow: 

**raw ingestion → deterministic cleaning (Python) → warehouse modeling with (dbt) → Power BI dashboard**

The primary focus is on building reliable, well-modeled analytical datasets, and using them to answer concrete business questions around sales performance, promotions, and competition.  

* * *

## Key environment 🔧

- **Python:** 3.11.9
- **dbt:** 1.10.17
- **PostgreSQL:** 16.11
- **Power BI:** latest (Desktop)

* * *

## How to run Project⚡

1.  Create & activate venv (Windows):  
    `python -m venv .venv && .venv\Scripts\activate`
2.  Install Python deps:  
    `pip install -r requirements.txt`
3.  Run ETL notebooks in order:
    - [01_explore_raw.ipynb](notebooks/01_explore_raw.ipynb)
    - [02_clean_transform.ipynb](notebooks\02_clean_transform.ipynb)
    - [03_load_postgre.ipynb](notebooks\03_load_postgre.ipynb)
4.  Initialize dbt and build models:
    - `cd rossmann_dbt`
    - `dbt deps` (install dbt packages)
    - `dbt debug`
    - `dbt build` (or `dbt run && dbt test`)
    - `dbt docs generate && dbt docs serve` (optional)
5.  Open Power BI and connect to PostgreSQL (host/port/dbname) for the dashboard.

* * *

## Repository structure 📁

```text
Rossmann_dbt  
├── data_raw/ # Raw input data (gitignored)  
├── data_clean/ # Cleaned outputs (gitignored)  
├── notebooks/ # Python ETL notebooks  
│ ├── 01_explore_raw.ipynb  
│ ├── 02_clean_transform.ipynb  
│ └── 03_load_postgre.ipynb  
├── rossmann_dbt/ # dbt project (models[staging,intermediate,marts], tests, packages.yml)  
│   ├── models/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   ├── tests/
│   ├── macros
│   ├── seeds
│   ├── snapshots
│   ├── dbt_project.yml
│   ├── packages.yml
│   └── profiles.example.yml (template file)
├── dashboard/ # Power BI files, Exports
├── images 
├── ETL_RUN_LOG.md # Executed ETL run documentation  
├── requirements.txt # Pinned Python deps
├── README.md
└── .gitignore
```

* * *

## Data cleaning (Python) ✨

Performed in the [02_clean_transform](notebooks\02_clean_transform.ipynb) 

Key steps: 
- Parsed dates
- Normalized holidays
- Validated & dropped inconsistent fields 
- Coerce stable dtypes
- Sanity checks (duplicates / open vs sales)
- Saved cleaned outputs to data_clean 🔧

Cleaned CSVs are produced locally and intentionally excluded from Git.

* * *

## dbt modeling & testing 🧩

- Sources: `raw.sales_raw`, `raw.stores_raw` (Defined in rossmann_dbt\models\staging\sources.yml )
- Layers: staging → intermediate → marts
- Tests: schema tests, business tests, `dbt_utils`\-based checks
- Note: dbt package `dbt_utils==1.3.3` is declared in `[package-lock.yml](rossmann_dbt\package-lock.yml)` and installed via `dbt deps`.

### dbt lineage graph

Generated via `dbt docs generate`:

![dbt Lineage Graph](images/dbt_lineage_graph.png)

This graph shows the full transformation flow from raw sources → staging → intermediate → marts → exposure.
* * *

## Dashboard (Power BI) 📊

The Power BI dashboard is built **on top of curated dbt marts** and designed as a **three-page analytical narrative** to answer key business questions. It progresses from executive-level monitoring to deeper analysis of sales drivers, promotional impact, and compettive effects, with fully interactive filtering across **date range, store type, and assortment level**.

---

### 1 - Executive Sales Overview

High-level performance view designed for leadership and rapid monitoring.

**Key KPIs**
- Total Sales  
- Total Customers  
- Average Daily Sales  
- Sales per Customer  
- % Days Closed  

**Key visuals & insights**

- Daily sales volatility vs 7-day moving average (trend smoothing)
- Sales vs customer traffic to distinguish volume vs basket effects
- Weekly seasonality pattern by day of week
- Overall sales trend highlighting structural patterns over time

![Executive Sales Overview](dashboards/dashboard_page1.png)

### 2 - Sales & Promotion Impact

Focused analysis of promotional effectiveness and uplift.

**Key KPIs**

- Promo uplift (%)
- Total promo vs non-promo sales
- Promo sales share
- Promo2 store coverage

**Key visuals & insights**

- Daily sales comparison: promo vs non-promo days
- Revenue contribution of promotions vs baseline sales
- Promo sales performance by day of week
- Average daily sales comparison: Promo2 vs non-Promo2 stores

![Sales and Promotion Impact](dashboards/dashboard_page2.png)

### 3 - Competition Impact on Store Performance

Store-level performance analysis with a focus on competitive pressure.

**Key KPIs**

Average daily sales per store
Number of stores
Average competition distance
% stores with nearby competition

**Key visuals & insights**

- Relationship between competition distance and store sales
- Average daily sales by store type
- Sales performance segmented by competition distance buckets
- Interaction between store type and competition proximity

![Competition Impact on Store Performance](dashboards/dashboard_page3.png)

### DAX & Semantic Layer

All core transformations and business logic are implemented in dbt and materialized in the warehouse.

DAX is intentionally limited to the semantic and analytical layer, where it is used for:

- time-intelligence calculations (rolling averages, comparisons)
- KPI derivations (average daily sales, promo uplift)
- slicer-aware dynamic measures
- analytical metrics required only at the visualization layer

This ensures a clean separation of responsibilities:

- dbt → single source of truth & transformations
- Power BI (DAX) → analytics, metrics, and presentation

## Versioning & milestones 🏷️

Each tagged version represents a **stable, runnable milestone** in the workflow.  
Tags are used intentionally as *save points* to reflect real analytics engineering phases.

### Versioning Strategy

- **Major versions** → new pipeline layer or end-user deliverable  
- **Minor versions** → completed modeling layers within dbt  
- **Patch versions** → fixes or adjustments after a tagged release  

Unfinished or experimental work is **never tagged**.

---

### Milestone Breakdown

| Version | Description |
|------|------------|
| **v0.1** | Project scaffold and repository structure |
| **v0.2.0** | Data cleaning pipeline finalized (Python) |
| **v0.3.0** | Cleaned data loaded and validated in PostgreSQL |
| **v1.0.0** | dbt initialized with sources and staging models |
| **v1.1.0** | Intermediate models with dbt tests |
| **v1.2.0** | BI-ready marts (facts & dimensions) |
| **v1.3.0** | Exposures and custom business tests |
| **v1.4.0** | Performance optimization (materializations & indexes) |
| **v1.4.1** | Post-release fixes to marts and exposures |
| **v2.0.0** | Final Power BI dashboard and documentation |

* * *

## Author

Raga, Junior Analytics Engineer (Analytics Engineering & BI) | Berlin, Germany
