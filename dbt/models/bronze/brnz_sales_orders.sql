{{
    config(
        materialized='view'
    )
}}

select
    SalesOrderID as sales_order_id,
    OrderDate as order_date,
    DueDate as due_date,
    ShipDate as ship_date,
    Status as status,
    OnlineOrderFlag as online_order_flag,
    SalesOrderNumber as sales_order_number,
    PurchaseOrderNumber as purchase_order_number,
    CustomerID as customer_id,
    SalesPersonID as sales_person_id,
    TerritoryID as territory_id,
    ModifiedDate as last_modified_date
from {{ source('adventureworks', 'SalesOrderHeader') }}
