with customers as (
    select * from {{ ref('stg_customers') }}
),
order_summary as (
    select
        customer_id,
        count(distinct order_id) as total_orders,
        sum(case when status = 'completed' then gross_revenue else 0 end) as lifetime_revenue,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date
    from {{ ref('fct_orders') }}
    group by customer_id
)
select
    c.customer_id,
    c.full_name,
    c.email,
    c.signup_date,
    coalesce(s.total_orders, 0) as total_orders,
    coalesce(s.lifetime_revenue, 0) as lifetime_revenue,
    s.first_order_date,
    s.most_recent_order_date
from customers c
left join order_summary s on c.customer_id = s.customer_id