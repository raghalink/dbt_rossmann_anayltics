{{ config(materialized='table')}}

with daily as (
  select *
  from {{ ref('fct_daily_sales') }}
)

select
  store_id,

  extract(isoyear from date_day)::int as year,
  extract(week    from date_day)::int as week,
  (extract(isoyear from date_day)::text || '-W' ||
   lpad(extract(week from date_day)::text, 2, '0')) as year_week,

  -- aggregated measures
  sum(sales)     as sales_week,
  sum(customers) as customers_week,

  -- activity counts
  sum(case when is_open then 1 else 0 end)     as open_days_count,
  sum(case when not is_open then 1 else 0 end) as closed_days_count,
  sum(case when has_promo then 1 else 0 end)   as promo_days_count

from daily
group by
  store_id,
  extract(isoyear from date_day),
  extract(week from date_day)
