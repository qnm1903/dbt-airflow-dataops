{{
    config(
        materialized='view'
    )
}}

select
    SalesOrderDetailID as order_detail_id,
    SalesOrderID as sales_order_id,
    ProductID as product_id,
    OrderQty as order_qty,
    UnitPrice as unit_price,
    UnitPriceDiscount as unit_price_discount,
    LineTotal as line_total,
    ModifiedDate as last_modified_date
from {{ source('adventureworks', 'SalesOrderDetail') }}
