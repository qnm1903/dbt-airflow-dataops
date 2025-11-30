{{
    config(
        materialized='view'
    )
}}

select
    CustomerID as customer_id,
    PersonID as person_id,
    StoreID as store_id,
    TerritoryID as territory_id,
    ModifiedDate as last_modified_date
from {{ source('adventureworks', 'Customer') }}
