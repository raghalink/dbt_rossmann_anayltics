{{ config(materialized='table') }}

with stores as (
  select *
  from {{ ref('stg_stores') }}
)

select
  store_id,
  store_type,
  assortment,
  competition_distance,
  competition_open_since_month,
  competition_open_since_year,
  has_promo2,
  promo2_since_week,
  promo2_since_year,
  promo2_interval
from stores
