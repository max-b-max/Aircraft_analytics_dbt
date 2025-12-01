WITH flight_passenger AS (
    SELECT
        f.flight_id,
        f.departure_airport_code AS airport_code,
        a.capacity AS nb_passengers,
        f.airline_code,
        f.aircraft_id
    FROM {{ ref('stg_individual_flight') }} f
    LEFT JOIN {{ ref('stg_aircraft') }} a 
        ON f.aircraft_id = a.aircraft_id

    UNION ALL

    SELECT
        f.flight_id,
        f.destination_airport_code AS airport_code,
        a.capacity AS nb_passengers,
        f.airline_code,
        f.aircraft_id
    FROM {{ ref('stg_individual_flight') }} f
    LEFT JOIN {{ ref('stg_aircraft') }} a 
        ON f.aircraft_id = a.aircraft_id
),

airport_agg AS (
    SELECT
        airport_code,
        COUNT(DISTINCT flight_id)           AS nb_flights,
        SUM(nb_passengers)                 AS nb_passengers,
        COUNT(DISTINCT airline_code)       AS nb_airlines,
        COUNT(DISTINCT aircraft_id)        AS nb_aircrafts
    FROM flight_passenger
    GROUP BY 1
)

SELECT
    d.airport_code,
    d.airport_name,
    d.airport_employees,
    d.airport_size,

    a.nb_flights,
    a.nb_passengers,
    a.nb_airlines,
    a.nb_aircrafts

FROM {{ ref('dim_airport') }} d
LEFT JOIN airport_agg a
    ON d.airport_code = a.airport_code
ORDER BY nb_passengers DESC
