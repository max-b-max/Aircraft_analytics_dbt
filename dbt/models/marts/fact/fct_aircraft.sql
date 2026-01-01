with flights as (
    select
        aircraft_id,
        airline_code,
        departure_airport_code,
        destination_airport_code
    from {{ ref('fct_individual_flights') }}
),

agg as (
    select
        aircraft_id,
        count(*) as total_flights,
        count(distinct airline_code) as total_airlines_served,
        count(distinct departure_airport_code)
            + count(distinct destination_airport_code) as nb_airports_served
    from flights
    group by aircraft_id
)

select
    ac.aircraft_id,
    ac.aircraft_type,
    ac.capacity,
    ag.total_flights,
    ag.total_airlines_served,
    ag.nb_airports_served
from agg ag
left join {{ ref('dim_aircraft') }} ac on ag.aircraft_id = ac.aircraft_id
