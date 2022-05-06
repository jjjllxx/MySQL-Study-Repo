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
WHERE can replace JOIN  
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
Exercise
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




