{{ config(materialized='table')}}

select
  store_id,
  date_day,
  sales,
  customers,
  is_open,
  has_promo,
  is_school_holiday,
  state_holiday_type,
  store_type,
  assortment,
  competition_distance,
  has_promo2

from {{ ref('int_sales_enriched') }}
