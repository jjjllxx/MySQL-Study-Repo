# Chapter 3 Retrieve Data(Multiple Table)

## Inner Joins
``` sql
SELECT *
FROM orders
JOIN customers
    ON orders.customer_id = customers.customer_id
```

For same column name in two tables, prefix should be added to indicates one table. Also use alias for a short expression.
``` sql
SELECT 
	order_id,
	o.customer_id,
    first_name,
    last_name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
```

EXERCISE
``` sql
SELECT
    order_id,
    oi.product_id,
    quantity,
    unit_price
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id
```
## Join Across Databases
Do not need to add prefix for the table from current database.
``` sql
USE sql_inventory;

SELECT * 
FROM sql_store.order_items oi
JOIN products p
     ON oi.product_id = p.product_id
```

## Self Joins
Join one table with itself, using different alias. For each column, prefix must be added.
``` sql
USE sql_hr;

SELECT 
    e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
JOIN employees m
     ON e.reports_to = m.employee_id
```

## Join Multiple Tables
Join more than 2 tables.
``` sql
USE sql_store;

SELECT 
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o
JOIN customers c
     ON o.customer_id = c.customer_id
JOIN order_statuses os
     ON o.status = os.order_status_id
```

EXERCISE
``` sql
USE sql_invoicing;

SELECT 
    p.date,
    p.invoice_id,
    p.amount,
    c.name,
    pm.name
FROM payments p
JOIN clients c
     ON p.client_id = c.client_id
JOIN payment_methods pm
     ON p.payment_method = pm.payment_method_id
```

## Compound Join Conditions
Use more than one columns(multiple condition) to combine two tables.  
Composite primary key: has two or more columns of primary key.

```sql
SELECT *
FROM order_items oi
JOIN order_item_notes oin
    ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id
```

## Implicit Join Syntax
WHERE can replace JOIN(not recommended)
``` sql
SELECT *
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;

-- Implicit Join Syntax(Not recommended)
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id
```

## Outer Joins
LEFT (OUTER) JOIN
RIGHT (OUTER) JOIN  OUTER is optional.
``` sql
SELECT
    c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
    ON o.customer_id = c.customer_id
ORDER BY c.customer_id
```

EXERCISE
```sql
SELECT
    p.product_id,
    p.name,
    oi.quantity
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
ORDER BY p.product_id
```

## Outer Joins Between Multiple Tables
LEFT JOIN is recommended
```sql
SELECT
    c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
    ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id
```

EXERCISE
``` sql
SELECT
    o.order_date,
    o.order_id,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
    ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
    ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
    ON o.status = os.order_status_id
```

## Self Outer Joins
Use different alias
``` sql
USE sql_hr;

SELECT 
    e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m
     ON e.reports_to = m.employee_id
```

## The USING Clause
If column name is the same, use USING clause to replace ON clause
``` sql
SELECT 
    o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
    -- ON o.customer_id = c.customer_id
    USING (customer_id)
LEFT JOIN shippers sh
    USING (shipper_id)
```

Composite primary key(primary key consists multiple columns) situation
``` sql
SELECT *
FROM order_items oi
JOIN order_item_notes oin
    -- ON oi.order_id = oin.order_id AND
        -- oi.product_id = oin.product_id
    USING (order_id, product_id)
```

EXERCISE
``` sql
USE sql_invoicing;

SELECT 
    p.date,
    c.name AS client,
    p.amount,
    pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
    ON p.payment_method = pm.payment_method_id
```

## Natural Joins
Join two tables basing on common columns(short but not recommended).Unexpected results.
``` sql
SELECT
    o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c
```

## Cross Joins
Combine every record from first table and every record from second table.
Explicit syntax
``` sql
SELECT 
    c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name
```

Implicit syntax(same results with explicit one)
``` sql
SELECT 
    c.first_name AS customer,
    p.name AS product
FROM customers c, products p
ORDER BY c.first_name
```

EXERCISE
```sql
-- implicit syntax
SELECT 
    sh.name AS shipper,
    p.name AS product
FROM shippers sh, products p
ORDER BY sh.name;

-- explicit syntax
SELECT 
    sh.name AS shipper,
    p.name AS product
FROM shippers sh
CROSS JOIN products p
ORDER BY sh.name;
```

## Unions
Combine rows from multiple tables.
``` sql
SELECT 
    order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >= '2019-01-01'
UNION
SELECT 
    order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01'
```

The number of columns should be the same.
First query determine the name of the column.
``` sql
SELECT first_name
FROM customers
UNION
SELECT name
FROM shippers
```

EXERCISE
``` sql
SELECT 
    customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers c
WHERE points >= 3000
UNION
SELECT 
    customer_id,
    first_name,
    points,
    'Silver' AS type
FROM customers c
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT 
    customer_id,
    first_name,
    points,
    'Bronze' AS type
FROM customers c
WHERE points < 2000
ORDER BY first_name
```
