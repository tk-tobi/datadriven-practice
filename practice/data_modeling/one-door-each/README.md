# One Door Each

*Every user picks a lane and stays in it. Model the world so the numbers stay honest.*

[Data Modeling · Medium · on DataDriven](https://datadriven.io/problems/one_door_each)

## How it went

| | |
|---|---|
| Solved | 2026-07-03 |
| Accepted | on the 7th submission |
| Time | 1 min |
| Hints | none |
| Concepts | Cardinality, Composite Keys, Constraints, Dimension Tables, Fact Tables, Foreign Keys, Grain Definition, Immutable Logs, Junction Tables, Many-to-Many, Metric Additivity, One-to-Many, Primary Keys, Star Schema, Surrogate Keys |

## The design

The accepted design, as it was graded:

```text
TABLE fact_event_log
  [PK] log_id INT
  timestamp TIMESTAMP
  [FK] user_id INT
  event VARCHAR
  [FK] date_id INT

TABLE dim_user
  [PK] user_id INT
  first_name VARCHAR
  last_name VARCHAR
  username VARCHAR
  email VARCHAR

TABLE dim_experiment
  [PK] experiment_id INT
  experiment_name VARCHAR
  start_date TIMESTAMP
  end_date TIMESTAMP
  status BOOLEAN

TABLE dim_variant_id
  [PK] variant_key INT
  variant_name VARCHAR

TABLE dim_date
  month INT
  [PK] date_id INT
  year INT
  quarter INT

TABLE fact_experiment_assignment
  event_id INT
  [PK] experiment_id INT
  time_stamp TIMESTAMP
  variant_id INT
  [PK] user_id INT

Relationships:
dim_experiment.experiment_id -> fact_experiment_assignment.experiment_id
fact_experiment_assignment.user_id -> fact_event_log.user_id
dim_user.user_id -> fact_experiment_assignment.user_id
dim_date.date_id -> fact_event_log.date_id
```
