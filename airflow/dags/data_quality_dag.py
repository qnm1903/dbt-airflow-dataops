from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator

default_args = {
    "owner": "dataops",
    "depends_on_past": False,
    "email_on_failure": True,
    "email": ["data-team@company.com"],
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

dag = DAG(
    "data_quality_validation",
    default_args=default_args,
    description="Run Great Expectations data quality validations",
    schedule_interval="0 */6 * * *",  # Every 6 hours
    start_date=datetime(2024, 1, 1),
    catchup=False,
    tags=["data-quality", "great-expectations"],
)

# Run GE checkpoints in the dbt container where GE is installed
validate_customers = BashOperator(
    task_id="validate_customer_data",
    bash_command=(
        "docker exec -w /usr/app/dbt/gx dbt_airflow_project-dbt-1 "
        "great_expectations checkpoint run customer_checkpoint"
    ),
    dag=dag,
)

validate_orders = BashOperator(
    task_id="validate_sales_order_data",
    bash_command=(
        "docker exec -w /usr/app/dbt/gx dbt_airflow_project-dbt-1 "
        "great_expectations checkpoint run sales_order_checkpoint"
    ),
    dag=dag,
)

generate_docs = BashOperator(
    task_id="generate_data_docs",
    bash_command=(
        "docker exec -w /usr/app/dbt/gx dbt_airflow_project-dbt-1 " "great_expectations docs build --assume-yes"
    ),
    dag=dag,
)

# Dependencies
[validate_customers, validate_orders] >> generate_docs
