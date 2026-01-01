select
    "Flight_Id"                 as flight_id,
    "Airline_Code"              as airline_code,
    "Aircraft_Id"               as aircraft_id,
    "Departure_Airport_Code"    as departure_airport_code,
    "Destination_Airport_Code"  as destination_airport_code
from {{ source('aircraft', 'individual_flights') }}
