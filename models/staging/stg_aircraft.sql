select
    "Aircraft_Id"               as aircraft_id,
    "Aircraft_Type"             as aircraft_type,
    cast("Mass" as float)       as mass,
    cast("Length" as float)     as length,
    cast("Cost" as float)       as cost,
    cast("Capacity" as int)     as capacity
from {{ source('aircraft', 'aircraft') }}
