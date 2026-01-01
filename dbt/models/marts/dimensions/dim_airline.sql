select
    airline_code,
    airline_name,
    description,
    market_cap,
    employees,
    age
from {{ ref('stg_airlines') }}
