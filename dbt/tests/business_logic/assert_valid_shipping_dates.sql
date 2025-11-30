-- Business Logic Test: Validate ShipDate is on or after OrderDate

select
    sales_order_id,
    order_date,
    ship_date
from {{ ref('slvr_sales_orders') }}
where ship_date < order_date
