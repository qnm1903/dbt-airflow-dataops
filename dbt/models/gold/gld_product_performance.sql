{{
    config(
        materialized='table'
    )
}}

with products as (
    select * from {{ ref('slvr_products') }}
),

sales as (
    select * from {{ ref('slvr_sales_orders') }}
),

product_sales as (
    select
        p.product_id,
        p.product_name,
        p.subcategory_name,
        p.color,
        p.list_price,
        p.standard_cost,
        coalesce(count(distinct s.sales_order_id), 0) as total_orders,
        coalesce(sum(s.order_qty), 0) as total_quantity_sold,
        coalesce(sum(s.line_total), 0) as total_revenue,
        coalesce(avg(s.unit_price), 0) as avg_selling_price,
        coalesce(sum(s.line_total), 0) - (coalesce(sum(s.order_qty), 0) * p.standard_cost) as total_profit,
        case
            when coalesce(sum(s.order_qty), 0) > 0 then
                (coalesce(sum(s.line_total), 0) - (coalesce(sum(s.order_qty), 0) * p.standard_cost)) / coalesce(sum(s.line_total), 1) * 100
            else 0
        end as profit_margin_pct
    from products p
    left join sales s
        on p.product_id = s.product_id
    group by
        p.product_id,
        p.product_name,
        p.subcategory_name,
        p.color,
        p.list_price,
        p.standard_cost
)

select * from product_sales
