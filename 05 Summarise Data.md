# Chapter 5 Summarize data
## Aggregate Functions
Aggregate function: take a series of values and aggregate them to produce a single value.  
Examples: MAX(), MIN(), AVERAGE(), SUM(), COUNT().(Only executed on non-NULL values, ignore NULL values)
``` sql
USE sql_invoicing;

SELECT 
    MAX(invoice_total) AS highest,
    MIN(invoice_total) AS lowest,
    AVG(invoice_total) AS average,
    SUM(invoice_total * 1.1) AS total, -- can be an expression
    COUNT(invoice_total) AS number_of_invoices,
    COUNT(payment_date) AS count_of_payments,
    COUNT(*) AS total_record,
    COUNT(DISTINCT client_id) AS total_records -- use DISTINCT to exclude duplicates
FROM invoices
WHERE invoice_date > '2019-07-01'
```

EXERCISE
``` sql
USE sql_invoicing;

SELECT
    'First half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION 
SELECT
    'Second half of 2019' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT
    'Total' AS date_range,
    SUM(invoice_total) AS total_sales,
    SUM(payment_total) AS total_payments,
	SUM(invoice_total - payment_total) AS what_we_expect
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31'
```

## The GROUP BY Clause
Group data by one or more columns.   
By default, data is sorted by the GROUP BY clause. Use ORDER BY to change the order.  
GROUP BY clause is after FROM and WHERE, before ORDER BY.  
Single column grouping example:
``` sql
SELECT
    client_id,
	SUM(invoice_total) AS total_sales
FROM invoices
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales DESC
```

Multiple columns grouping example;
``` sql
SELECT
	state,
    city,
	SUM(invoice_total) AS total_sales
FROM invoices i
JOIN clients USING (client_id)
GROUP BY state, city
```

EXERCISE
``` sql
SELECT
	date,
    pm.name AS payment_method,
	SUM(amount) AS total_payments
FROM payments p
JOIN payment_methods pm
ON p.payment_method = pm.payment_method_id
GROUP BY date, payment_method
ORDER BY date
```

## The HAVING Clause
HAVING clause used after GROUP BY clause as a selecting condition.  
HAVING clause filters data after grouping, WHERE clause filters data before grouping.
``` sql
SELECT
    client_id,
	SUM(invoice_total) AS total_sales
FROM invoices
GROUP BY client_id
HAVING total_sales > 500
```
