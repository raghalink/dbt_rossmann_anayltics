{{ config(materialized='view') }}

with sales as (
  select *
  from {{ ref('stg_sales') }}
),
stores as (
  select *
  from {{ ref('stg_stores') }}
)

select
  s.store_id,
  s.date_day,
  s.sales,
  s.customers,
  s.is_open,
  s.has_promo,
  s.state_holiday_type,
  s.is_school_holiday,

  st.store_type,
  st.assortment,
  st.competition_distance,
  st.competition_open_since_month,
  st.competition_open_since_year,
  st.has_promo2,
  st.promo2_since_week,
  st.promo2_since_year,
  st.promo2_interval

from sales s
left join stores st
on s.store_id = st.store_id
