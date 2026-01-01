select
    airport_code,
    airport_name,
    airport_employees,
    airport_size
from {{ ref('stg_airports') }}