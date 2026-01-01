# dbt Models – Documentation Technique

Ce dossier contient l’ensemble des modèles dbt du projet Aircraft Analytics.

## Structure du projet

```
models/
│
├── staging/
│   ├── stg_aircraft.sql
│   ├── stg_airlines.sql
│   ├── stg_airports.sql
│   ├── stg_individual_flight.sql
│   ├── stg_flight_summary_data.sql
│   └── stg_schema.yml
│
├── dimensions/
│   ├── dim_aircraft.sql
│   ├── dim_airline.sql
│   ├── dim_airport.sql
│   └── dim_schema.yml
│
├── fact/
│   ├── fct_aircraft.sql
│   ├── fct_airport.sql
│   ├── fct_flight_summary.sql
│   ├── fct_individual_flights.sql
│   └── fct_schema.yml
│
└── documentation.md
```

---

## Sources (`raw.public`)
Les données brutes proviennent de Snowflake (`raw.public`) :

- `aircraft`
- `airlines`
- `airports`
- `flight_summary_data`
- `individual_flights`

Déclarées dans :  
**`sources.yml`**

---

## Layer Staging (`stg_`)
Les modèles **stg_** :
- normalisent les colonnes,
- nettoient les types,
- harmonisent les codes (`airline_code`, `airport_code`, `aircraft_id`),
- préparent les données pour les couches DIM/FCT.

Modèles :

- `stg_aircraft.sql`  
- `stg_airlines.sql`  
- `stg_airports.sql`  
- `stg_individual_flight.sql`  
- `stg_flight_summary_data.sql`  

Tests définis dans :  
`stg_schema.yml`

---

## Dimensions (`dim_`)
Les dimensions décrivent les entités métiers, sans agrégation.

### `dim_aircraft.sql`
Caractéristiques avion :  
- modèle, masse, longueur, coût  
- capacité passagers  

### `dim_airline.sql`
Informations compagnie :  
- code, nom  
- description, employés, âge  

### `dim_airport.sql`
Référentiel aéroports :  
- code, nom, taille, employés  

Tests DIM :  
`dim_schema.yml`

---

## Tables Analytics / Facts (`fct_`)
Tables analytiques compilant les métriques clés.

### `fct_individual_flights`
- grain : 1 ligne = 1 vol  
- enrichi avec avion + compagnie + aéroports  
- permet de compter les vols, estimer les passagers, analyser les routes

### `fct_flight_summary`
- grain : 1 ligne = 1 jour × airline × airport  
- KPIs : ASM, RPM, vols, passagers domestic/international  
- permet d’analyser croissance ASM et meilleur RPM

### `fct_aircraft`
- grain : 1 avion  
- KPIs : nb vols, nb compagnies, nb d’aéroports desservis  

### `fct_airport`
- grain : 1 aéroport  
- agrège arrivées + départs  
- KPIs : nb vols, nb passagers estimés, nb compagnies, nb avions