select
    "Airline_Code"                  as airline_code,
    trim("Airline_Name")            as airline_name,
    "Description"                   as description,
    cast("Market_Cap" as float)     as market_cap,
    cast("Employees" as int)        as employees,
    cast("Age" as int)              as age
from {{ source('aircraft', 'airlines') }}

