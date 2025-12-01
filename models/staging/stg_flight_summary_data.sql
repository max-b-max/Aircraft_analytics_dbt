select
    cast("Date" as date)                        as date,
    "Airline_Code"                              as airline_code,
    "Airport_Code"                              as airport_code,
    cast("ASM_Domestic" as float)               as asm_domestic,
    cast("ASM_International" as float)          as asm_international,
    cast("Flights_Domestic" as int)             as flights_domestic,
    cast("Flights_International" as int)        as flights_international,
    cast("Passengers_Domestic" as int)          as passengers_domestic,
    cast("Passengers_International" as int)     as passengers_international,
    cast("RPM_Domestic" as float)               as rpm_domestic,
    cast("RPM_International" as float)          as rpm_international
from {{ source('aircraft', 'flight_summary_data') }}
