{% test string_length(model, column_name, min_len=0, max_len=255) %}

    select *
    from {{ model }}
    where len({{ column_name }}) < {{ min_len }}
       or len({{ column_name }}) > {{ max_len }}

{% endtest %}
