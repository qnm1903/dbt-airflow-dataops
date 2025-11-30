{{
    config(
        materialized='view'
    )
}}

select
    BusinessEntityID as person_id,
    PersonType as person_type,
    FirstName as first_name,
    LastName as last_name,
    EmailPromotion as email_promotion,
    ModifiedDate as last_modified_date
from {{ source('adventureworks_person', 'Person') }}
