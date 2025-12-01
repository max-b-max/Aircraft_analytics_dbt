with summary as (
    select
        date,
        airline_code,
        airport_code,
        asm_domestic,
        asm_international,
        flights_domestic,
        flights_international,
        passengers_domestic,
        passengers_international,
        coalesce(rpm_domestic, 0) as rpm_domestic,
        coalesce(rpm_international, 0) as rpm_international
    from {{ ref('stg_flight_summary_data') }}
),

airlines as (
    select airline_code, airline_name
    from {{ ref('dim_airline') }}
),

airports as (
    select airport_code, airport_name
    from {{ ref('dim_airport') }}
)

select
    s.date,
    s.airline_code,
    al.airline_name,

    s.airport_code,
    ap.airport_name,

    s.asm_domestic,
    s.asm_international,
    s.flights_domestic,
    s.flights_international,
    s.passengers_domestic,
    s.passengers_international,
    s.rpm_domestic,
    s.rpm_international,

    s.rpm_domestic + s.rpm_international as rpm_total

from summary s
left join airlines al on s.airline_code = al.airline_code
left join airports ap on s.airport_code = ap.airport_code