-- Test fails if it returns any rows

select
  store_id,
  date_day,
  is_open,
  customers
from {{ ref('stg_sales') }}
where is_open = false
  and customers > 0
