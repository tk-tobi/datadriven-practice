# The Balance Always Reconciles

*Money out, payments back. The balance has to be exact.*

[Data Modeling · Easy · on DataDriven](https://datadriven.io/problems/the_balance_always_reconciles)

## How it went

| | |
|---|---|
| Solved | 2026-06-29 |
| Accepted | on the 3rd submission |
| Time | 2 min |
| Hints | none |
| Concepts | Attributes, Constraints, Data Types, Dimension Tables, Entities, Fact Tables, 1NF, Foreign Keys, Grain Definition, One-to-Many, Primary Keys, 2NF, Snowflake Schema, 3NF |

## The design

The accepted design, as it was graded:

```text
TABLE dim_customers
  [PK] customer_key INT
  customer_id INT
  first_name VARCHAR
  last_name VARCHAR
  resident_state VARCHAR
  credit_score INT

TABLE dim_products
  [PK] product_key INT
  product_id INT
  product_name VARCHAR
  standard_rate FLOAT
  standard_term FLOAT

TABLE dim_date
  [PK] date_key INT
  year DATE
  month INT
  quarter INT

TABLE fct_payments_transactions
  transaction_id INT
  [FK] customer_key INT
  [FK] contract_key INT
  [FK] date_key INT
  payment_timestamp TIMESTAMP
  amount FLOAT

TABLE dim_contracts
  [PK] contract_key UUID
  contract_id INT
  [FK] customer_key INT
  [FK] product_key INT
  sign_date DATE
  principal FLOAT
  minimum_payment FLOAT

Relationships:
dim_contracts.customer_key -> dim_customers.customer_key
dim_products.product_key -> dim_contracts.product_key
fct_payments_transactions.contract_key -> dim_contracts.contract_key
fct_payments_transactions.date_key -> dim_date.date_key
fct_payments_transactions.customer_key -> dim_customers.customer_key
```
