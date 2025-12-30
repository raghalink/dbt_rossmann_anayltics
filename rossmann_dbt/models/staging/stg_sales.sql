{{ config(materialized='view') }}

with src as (
  select *
  from {{ source('raw', 'sales_raw') }}
)

select
  "Store"::int                              as store_id,
  to_date("Date", 'YYYY-MM-DD')             as date_day,
  "Sales"::int                              as sales,
  "Customers"::int                          as customers,
  ("Open"::int = 1)                         as is_open,
  ("Promo"::int = 1)                        as has_promo,
  nullif(trim("StateHoliday"::text), '0')   as state_holiday_type,
  ("SchoolHoliday"::int = 1)                as is_school_holiday
from src
