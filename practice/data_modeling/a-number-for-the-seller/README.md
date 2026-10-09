# A Number for the Seller

*They want a total. Give them the right schema first.*

[Data Modeling · Easy · on DataDriven](https://datadriven.io/problems/a_number_for_the_seller)

## How it went

| | |
|---|---|
| Solved | 2026-06-08 |
| Accepted | on the 6th submission |
| Time | 1 min |
| Hints | none |
| Concepts | Dimension Tables, Fact Tables, Foreign Keys, Grain Definition, Metric Additivity, One-to-Many, Pre-Aggregation, Primary Keys, Star Schema, Surrogate Keys |

## The design

The accepted design, as it was graded:

```text
TABLE dim_products
  [PK] product_key INT
  name VARCHAR
  category VARCHAR
  price FLOAT
  rating FLOAT
  [FK] seller_key INT
  listed_at TIMESTAMP
  is_active BOOLEAN
  product_id INT

TABLE dim_seller
  [PK] seller_key INT
  category VARCHAR
  name VARCHAR
  phone_number BIGINT
  address VARCHAR
  bank_account_num BIGINT
  seller_id INT

TABLE sales_fact
  [PK] id INT
  [FK] seller_key INT
  [FK] product_key INT
  sale_timestamp TIMESTAMP
  gross_revenue FLOAT
  quantity INT
  [FK] date_key INT

TABLE dim_date
  [PK] id INT
  full_date DATE
  day_of_week INT
  month INT
  year INT

Relationships:
sales_fact.product_key -> dim_products.product_key (none)
sales_fact.seller_key -> dim_seller.seller_key (none)
dim_products.seller_key -> dim_seller.seller_key (none)
sales_fact.date_key -> dim_date.id (none)
```
