# Chapter 06 Complex Queries

## Subqueries
``` sql
USE sql_store;

SELECT *
FROM products
WHERE unit_price > (
    SELECT unit_price
    FROM products
    WHERE product_id = 3
)
```

EXERCISE
``` sql
USE sql_hr;

SELECT *
FROM employees
WHERE salary > (
    SELECT 
    AVG(salary)
    FROM employees
)
```

## The IN Operator
``` sql
USE sql_store;

SELECT *
FROM products
WHERE product_id NOT IN (
    SELECT DISTINCT product_id
    FROM order_items
)
```
EXERCISE
``` sql
USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id NOT IN (
    SELECT DISTINCT client_id
    FROM invoices
)
```

## Subqueries vs Joins
This example shares same result with last EXERCISE.  
Sometimes Subqueries and Joins have same result. Take care of readability.
``` sql
USE sql_invoicing;

SELECT *
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL
```

EXERCISE(two methods)
```sql
USE sql_store;

-- Subqueries
SELECT 
    customer_id,
    first_name,
    last_name
FROM customers
WHERE customer_id IN (
	SELECT customer_id
    FROM orders o
    JOIN order_items oi USING (order_id)
    WHERE oi.product_id = 3
);

-- Joins
SELECT DISTINCT
    customer_id,
    first_name,
    last_name
FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id)
WHERE oi.product_id = 3
```

## The ALL Keyword
``` sql
USE sql_invoicing;

SELECT *
FROM invoices 
WHERE invoice_total > (
    SELECT MAX(invoice_total)
    FROM invoices
    WHERE client_id = 3
)
```

ALL keyword
``` sql
USE sql_invoicing;

SELECT *
FROM invoices 
WHERE invoice_total > ALL (
    SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
)
```

## The ANY Keyword
``` sql
USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id IN (
    SELECT client_id
    FROM invoices 
    GROUP BY client_id
    HAVING COUNT(*) >= 2
)
```

ANY Keyword
``` sql
USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id = ANY (
    SELECT client_id
    FROM invoices 
    GROUP BY client_id
    HAVING COUNT(*) >= 2
)
```

## Correlated Subqueries
``` sql
USE sql_hr;

SELECT *
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
)
```

EXERCISE
``` sql
USE sql_invoicing;

SELECT *
FROM invoices i
JOIN clients c USING (client_id)
WHERE invoice_total > (
    SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = c.client_id
)
```

## The EXISTS Operation
EXISTS operator is more efficient than IN operator if the result set is very large.
``` sql
USE sql_invoicing;

SELECT *
FROM clients c
WHERE EXISTS (
    SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
)
```

EXERCISE
``` sql 
USE sql_store;

SELECT *
FROM products p
WHERE NOT EXISTS (
    SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
)
```

## Subqueries in the SELECT Clause
``` sql
USE sql_invoicing;

SELECT
    invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total)
	FROM invoices) AS invoice_average,
    invoice_total - (SELECT invoice_average) AS difference
FROM invoices
```

EXERCISE
My Method
``` sql
USE sql_invoicing;

SELECT
    c.client_id,
    name,
    SUM(invoice_total) AS total_sales,
    (SELECT AVG(invoice_total)
        FROM invoices) AS average,
    SUM(invoice_total) - (SELECT average) AS difference
FROM clients c
LEFT JOIN invoices USING (client_id)
GROUP BY c.client_id
```

Code in the video
``` sql
USE sql_invoicing;

SELECT
    c.client_id,
    name,
    (SELECT SUM(invoice_total)
	FROM invoices
        WHERE client_id = c.client_id) AS total_sales,
    (SELECT AVG(invoice_total) FROM invoices) AS average,
    (SELECT total_sales - average) AS difference
FROM clients c
```

## Subqueries in the FROM Clause
``` sql
USE sql_invoicing;
SELECT *
FROM (
    SELECT
	c.client_id,
	name,
	(SELECT SUM(invoice_total)
	    FROM invoices
	    WHERE client_id = c.client_id) AS total_sales,
	(SELECT AVG(invoice_total) FROM invoices) AS average,
	(SELECT total_sales - average) AS difference
	FROM clients c
) AS sales_summary
WHERE total_sales IS NOT NULL
```
