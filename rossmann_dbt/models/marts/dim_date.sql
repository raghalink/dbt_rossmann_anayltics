{{ config(materialized='table') }}

with dates as (
  select distinct
    date_day
  from {{ ref('stg_sales') }}
)

select
  date_day,
  extract(year  from date_day)::int  as year,
  extract(month from date_day)::int  as month,
  to_char(date_day, 'Mon')           as month_name,
  extract(week  from date_day)::int  as week,
  extract(isodow from date_day)::int as day_of_week,
  to_char(date_day, 'Dy')            as day_name,
  (extract(isodow from date_day) in (6,7)) as is_weekend
from dates
