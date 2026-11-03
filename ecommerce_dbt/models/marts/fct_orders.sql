with orders as (
    select * from {{ ref('stg_orders') }}
),
products as (
    select * from {{ ref('stg_products') }}
)
select
    o.order_id,
    o.customer_id,
    o.product_id,
    o.order_date,
    o.status,
    o.quantity,
    p.unit_price,
    p.unit_cost,
    round(o.quantity * p.unit_price, 2) as gross_revenue,
    round(o.quantity * p.unit_cost, 2) as total_cogs,
    round((o.quantity * p.unit_price) - (o.quantity * p.unit_cost), 2) as gross_profit
from orders o
left join products p on o.product_id = p.product_id