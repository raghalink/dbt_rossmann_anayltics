{{ config(materialized='table',post_hook=["create index if not exists idx_fct_daily_sales_date_day on {{ this }} (date_day)","create index if not exists idx_fct_daily_sales_store_date on {{ this }} (store_id, date_day)","analyze {{ this }}"]) }}

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
