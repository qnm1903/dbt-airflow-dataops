-- Test: All revenue values must be positive
SELECT
    sales_order_id,
    line_total
FROM {{ ref('brnz_sales_order_details') }}
WHERE line_total < 0
