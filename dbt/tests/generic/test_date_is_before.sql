{% test date_is_before(model, column_name, target_date_column) %}

    select *
    from {{ model }}
    where {{ column_name }} >= {{ target_date_column }}

{% endtest %}
