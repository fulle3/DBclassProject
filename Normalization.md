# Normalization for MN MarketLink Database

This document explains how the core tables in the MN MarketLink database (Products and Orders) satisfy Third Normal Form (3NF).

We briefly check 1NF and 2NF first, then show there are no transitive dependencies, so the tables are in 3NF.

---

## 1. First Normal Form (1NF)

A table is in 1NF if:
- All attributes contain atomic values.
- There are no repeating groups or arrays.
- Each field stores a single value.

### Product table

**Attributes:**
- product_id (PK)
- vendor_id (FK)
- product_name
- category
- unit_price
- stock_quantity

All attributes are single valued:
- product_name is one name, not a list.
- category is one category per product.
- unit_price is a single numeric value.
- stock_quantity is a single integer.

There are no repeating groups or multivalued columns.  
Therefore, `Product` is in 1NF.

### Order table

**Attributes:**
- order_id (PK)
- customer_id (FK)
- pickup_market_id (FK)
- order_date
- total_price

All attributes are atomic:
- order_date is a single datetime.
- total_price is a single numeric value.

Order items are stored separately in the `OrderItem` table, so there are no repeating groups inside `Order`.  
Therefore, `Order` is in 1NF.

---

## 2. Second Normal Form (2NF)

A table is in 2NF if:
- It is in 1NF.
- Every non key attribute depends on the whole primary key, not just part of it.

In our design:
- `Product` has a single attribute primary key: `product_id`
- `Order` has a single attribute primary key: `order_id`

Since the primary keys are not composite, every non key attribute automatically depends on the whole key.

For `Product`:
- product_name, category, unit_price, stock_quantity all depend on product_id.

For `Order`:
- customer_id, pickup_market_id, order_date, total_price all depend on order_id.

So `Product` and `Order` are in 2NF.

---

## 3. Third Normal Form (3NF)

A table is in 3NF if:
- It is in 2NF.
- There are no transitive dependencies (non key attribute depending on another non key attribute).

We check for any non key attribute that determines another non key attribute.

### Product table and 3NF

Attributes:
- product_id (PK)
- vendor_id (FK)
- product_name
- category
- unit_price
- stock_quantity

Dependencies:
- product_id → vendor_id, product_name, category, unit_price, stock_quantity

There is no case where:
- vendor_id determines another non key inside this table, or
- product_name, category, unit_price, or stock_quantity determine each other.

Vendor details are stored in the `Vendor` table instead of inside `Product`.  
So there are no transitive dependencies.

Therefore, `Product` is in 3NF.

### Order table and 3NF

Attributes:
- order_id (PK)
- customer_id (FK)
- pickup_market_id (FK)
- order_date
- total_price

Dependencies:
- order_id → customer_id, pickup_market_id, order_date, total_price

There is no non key attribute that determines another non key attribute:
- customer details are in the `Customer` table.
- market details are in the `FarmersMarket` table.
- order_date and total_price are specific to the order_id.

So there are no transitive dependencies in `Order`.

Therefore, `Order` is also in 3NF.

---

## 4. Summary

- All tables use atomic attributes (1NF).
- Tables with single column primary keys have all non key attributes depending on the full key (2NF).
- Non key attributes do not determine other non key attributes. Related data is moved to separate tables (`Vendor`, `Customer`, `FarmersMarket`) (3NF).

Therefore, the core tables `Product` and `Order` are normalized to at least Third Normal Form (3NF) as required.
