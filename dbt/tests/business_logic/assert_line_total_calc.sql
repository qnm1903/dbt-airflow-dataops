-- Business Logic Test: Validate LineTotal calculation
-- LineTotal should equal OrderQty * UnitPrice * (1 - UnitPriceDiscount)
-- Allowing for small floating point differences (e.g. 0.01)

select
    sales_order_id,
    order_detail_id,
    line_total,
    order_qty,
    unit_price,
    unit_price_discount,
    (order_qty * unit_price * (1 - unit_price_discount)) as expected_total,
    abs(line_total - (order_qty * unit_price * (1 - unit_price_discount))) as diff
from {{ ref('slvr_sales_orders') }}
where abs(line_total - (order_qty * unit_price * (1 - unit_price_discount))) > 0.05
