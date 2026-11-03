with source as (
    select * from {{ ref('raw_orders') }}
)
select
    order_id,
    customer_id,
    product_id,
    cast(order_date as date) as order_date,
    cast(quantity as integer) as quantity,
    status
from source