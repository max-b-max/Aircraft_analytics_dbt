select
    "Airport_Code"                      as airport_code,
    trim("Airport_Name")                as airport_name,
    cast("Airport_Employees" as int)    as airport_employees,
    trim("Airport_Size")                as airport_size
from {{ source('aircraft', 'airports') }}
