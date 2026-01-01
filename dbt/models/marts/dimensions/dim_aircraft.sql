
select
    aircraft_id,
    aircraft_type,
    mass,
    length,
    cost,
    capacity
from {{ ref('stg_aircraft') }}
