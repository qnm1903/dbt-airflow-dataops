{% test regex_match(model, column_name, pattern) %}

    select *
    from {{ model }}
    where {{ column_name }} is not null
      and patindex('{{ pattern }}', {{ column_name }}) = 0

{% endtest %}
