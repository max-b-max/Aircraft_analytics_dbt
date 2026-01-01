with flights as (
    select
        flight_id,
        airline_code,
        aircraft_id,
        departure_airport_code,
        destination_airport_code
    from {{ ref('stg_individual_flight') }}
),

airlines as (
    select airline_code, airline_name
    from {{ ref('dim_airline') }}
),

aircraft as (
    select aircraft_id, aircraft_type, capacity
    from {{ ref('dim_aircraft') }}
),

airports as (
    select airport_code, airport_name
    from {{ ref('dim_airport') }}
)

select
    f.flight_id,

    -- Airline
    f.airline_code,
    al.airline_name,

    -- Aircraft
    f.aircraft_id,
    ac.aircraft_type,
    ac.capacity,

    -- Airports
    f.departure_airport_code,
    dap.airport_name as departure_airport_name,

    f.destination_airport_code,
    aap.airport_name as destination_airport_name

from flights f
left join airlines al on f.airline_code = al.airline_code
left join aircraft ac on f.aircraft_id = ac.aircraft_id
left join airports dap on f.departure_airport_code = dap.airport_code
left join airports aap on f.destination_airport_code = aap.airport_code