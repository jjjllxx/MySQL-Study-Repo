# Chapter 2 Retrieve Data(Single Table)

## The SELECT Statement
SELECT: choose all columns or some of columns.  
WHERE: select condition.  
ORDER BY: sort rows by keyword.  
``` sql
USE sql_store;

SELECT *
FROM customers
-- WHERE customer_id = 1
ORDER BY first_name
```
## The SELECT Clause
Calculation operations can be down to columns.  
AS: set the name of columns
``` sql
USE sql_store;

SELECT 
	last_name,
    first_name,
    points,
    points * 10 + 100 AS 'discount factor'
FROM customers
```

DISTINCT: exclude duplicates.
``` sql
SELECT DISTINCT state
FROM customers
```

EXERCISE
``` sql
SELECT 
    name, 
    unit_price,
    unit_price * 1.1 AS new_price
FROM products
```

## The WHERE Clause
Symbols: >, <, >=, <=, = ,!=/<>
Two examples:
``` sql
SELECT *
FROM Customers
WHERE state = 'VA'
```
Date format: 4 digits for the year, 2 digits for the month, 2 digits for the day.
``` sql
SELECT *
FROM Customers
WHERE birth_date > '1990-01-01'
```

EXERCISE
``` sql
SELECT *
FROM Orders
WHERE order_date > '2019-01-01'
```

## The AND, OR and NOT operators
Examples
``` sql
SELECT *
FROM Customers
WHERE birth_date > '1990-01-01' AND points > 1000
```

``` sql
SELECT *
FROM Customers
WHERE birth_date > '1990-01-01' OR points > 1000
```

These logical operators can be combined to use. AND operator is evaluated first. USE () to overwrite.
NOT: negate a condition
``` sql
SELECT *
FROM Customers
WHERE NOT (birth_date > '1990-01-01' OR points > 1000)
```

EXERCISE
``` sql
SELECT *
FROM order_items
WHERE order_id = 6 AND unit_price * quantity > 30
```
