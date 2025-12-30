{{ config(materialized='view') }}

with src as (
  select *
  from {{ source('raw', 'stores_raw') }}
)

select
  "Store"::int                             as store_id,
  "StoreType"::text                        as store_type,
  "Assortment"::text                       as assortment,
  round("CompetitionDistance")::int        as competition_distance,
  round("CompetitionOpenSinceMonth")::int  as competition_open_since_month,
  round("CompetitionOpenSinceYear")::int   as competition_open_since_year,
  ("Promo2"::int = 1)                      as has_promo2,
  round("Promo2SinceWeek")::int            as promo2_since_week,
  round("Promo2SinceYear")::int            as promo2_since_year,
  "PromoInterval"::text                    as promo2_interval
from src

