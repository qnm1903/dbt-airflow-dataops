{{
    config(
        materialized='table'
    )
}}

with customers as (
    select * from {{ ref('brnz_customers') }}
),

person as (
    select * from {{ ref('brnz_person') }}
),

joined as (
    select
        c.customer_id,
        coalesce(p.first_name, 'Unknown') as first_name,
        coalesce(p.last_name, 'Unknown') as last_name,
        concat(coalesce(p.first_name, 'Unknown'), ' ', coalesce(p.last_name, 'Unknown')) as full_name,
        p.email_promotion,
        c.store_id,
        c.territory_id,
        c.last_modified_date
    from customers c
    left join person p
        on c.person_id = p.person_id
)

select * from joined
