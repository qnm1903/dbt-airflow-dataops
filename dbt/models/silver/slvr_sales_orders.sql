{{
    config(
        materialized='table'
    )
}}

with sales_header as (
    select * from {{ ref('brnz_sales_orders') }}
),

sales_detail as (
    select * from {{ ref('brnz_sales_order_details') }}
),

joined as (
    select
        h.sales_order_id,
        d.order_detail_id,
        h.order_date,
        h.due_date,
        h.ship_date,
        h.status,
        case
            when h.online_order_flag = 1 then 'Online'
            else 'Offline'
        end as order_channel,
        h.sales_order_number,
        h.purchase_order_number,
        h.customer_id,
        h.sales_person_id,
        h.territory_id,
        d.product_id,
        d.order_qty,
        d.unit_price,
        d.unit_price_discount,
        d.line_total,
        -- Calculated fields
        d.unit_price * d.order_qty as gross_amount,
        d.line_total / nullif(d.order_qty, 0) as effective_unit_price,
        case
            when d.unit_price_discount > 0 then 1
            else 0
        end as has_discount
    from sales_header h
    left join sales_detail d
        on h.sales_order_id = d.sales_order_id
    where d.order_qty > 0
        and d.unit_price >= 0
)

select * from joined
