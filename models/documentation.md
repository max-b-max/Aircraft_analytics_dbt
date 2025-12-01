# Aircraft Analytics – Documentation du Projet ✈️📊

## 🎯 Objectif du projet
Ce projet dbt vise à construire un pipeline analytique complet permettant
l’analyse des performances aéronautiques à partir des données brutes :
- avions,
- compagnies aériennes,
- aéroports,
- trafic aérien (ASM, RPM, passagers),
- vols individuels.

L’objectif final est de fournir :
- Des **dimensions propres** (`dim_aircraft`, `dim_airline`, `dim_airport`)
- Des **tables analytiques** (`fct_individual_flights`, `fct_airport`, `fct_flight_summary`…)
- Une base solide pour Deepnote, Power BI et les analyses avancées.

---

## 📂 Architecture du projet

Dossier `models/` :

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

## 📥 Sources (`raw.public`)
Les données brutes proviennent de Snowflake (`raw.public`) :

- `aircraft`
- `airlines`
- `airports`
- `flight_summary_data`
- `individual_flights`

Déclarées dans :  
**`sources.yml`**

---

## 🧹 Layer Staging (`stg_`)
Les modèles **stg_** :
- standardisent les colonnes,
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

## 🧱 Dimensions (`dim_`)
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

## 📊 Tables Analytics / Facts (`fct_`)

### ✈️ `fct_individual_flights.sql`
**Grain : 1 ligne = 1 vol**

Enrichi avec : avion + compagnie + aéroports  
Usages :
- nombre de vols par avion  
- passagers estimés (capacité avion)  
- analyse routes et compagnie  

---

### 📈 `fct_flight_summary.sql`
**Grain : 1 ligne = 1 jour × airline × airport**

Mesures :
- ASM domestic/international  
- RPM domestic/international/total  
- vols domestic/international  
- passagers par type  

Usages :
- meilleure année RPM  
- croissance ASM  
- trafic par aéroport  

---

### 🛩️ `fct_aircraft.sql`
**Grain : 1 avion**

KPI :
- total_flights  
- total_airlines_served  
- nb_airports_served  

Usages :
- analyser l’usage d’un avion  
- comparer les modèles d’avions  

---

### 🛫 `fct_airport.sql`
**Grain : 1 ligne = 1 aéroport**

Basée sur `fct_individual_flights`  

KPIs :
- nb_flights (arrivées + départs)  
- nb_passengers (approx via capacité avion)  
- nb_airlines  
- nb_aircrafts  
- attributs de `dim_airport`  

Usages :
- identifier l’aéroport ayant transporté le plus de passagers  
- analyser l’activité d’un hub  

---