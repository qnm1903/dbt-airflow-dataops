SELECT
    order_detail_id,
    COUNT(*) as duplicate_count
FROM {{ ref('brnz_sales_order_details') }}
GROUP BY order_detail_id
HAVING COUNT(*) > 1
