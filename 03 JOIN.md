# Chapter 3 JOIN
## Inner Joins

## Join Across Databases

## Self Joins

## Join Multiple Tables

## Compound Join Conditions
```sql
USE sql_invoicing;

SELECT 
    p.payment_id,
    c.client_id,
    p.invoice_id,
    p.date,
    p.amount,
    p.payment_method
FROM payments p
JOIN clients c
    ON p.client_id = c.client_id
JOIN payment_methods pm
    ON p.payment_method = pm.payment_method_id
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
