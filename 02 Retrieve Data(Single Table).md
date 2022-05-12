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

## The IN operator
``` sql
SELECT *
FROM Customers
WHERE state IN ('VA', 'FL', 'GA')
```

EXERCISE
``` sql
SELECT *
FROM products
WHERE quantity_in_stock IN (49, 38, 72)
```

## The BETWEEN Operator
BETWEEN Operator includes lower bound and upper bound(In the following example, the range is 1000 <= points <= 3000).
``` sql
SELECT *
FROM Customers
WHERE points BETWEEN 1000 AND 3000
```

EXERCISE
``` sql
SELECT *
FROM Customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'
```

## The LIKE Operator
% indicates any number of any character
In the following example, 'b' can be lower case or upper case.
``` sql
SELECT *
FROM Customers
WHERE last_name LIKE 'b%'
```

Find all the customers with 'b' in last name.
``` sql
SELECT *
FROM Customers
WHERE last_name LIKE '%b%'
```

_ indicates a single character.
``` sql
SELECT *
FROM Customers
WHERE last_name LIKE '_____y'
```

EXERCISE
``` sql
SELECT *
FROM Customers
WHERE address LIKE '%trail%' OR
      address LIKE '%avenue%'
```

``` sql
SELECT *
FROM Customers
WHERE phone LIKE '%9'
```

## The REGEXP Operator
REGEXP: regular expression.
In the following example, the LIKE clause has the same result with the REGEXP clause.
``` sql
SELECT *
FROM Customers
-- WHERE last_name LIKE '%field'
WHERE last_name REGEXP 'field'
```

^ indicates the beginning of a string(put ^ in the beginning of the pattern).   
$ indicates the end of a string(put $ at the end of the pattern).
``` sql
SELECT *
FROM Customers
-- WHERE last_name REGEXP '^field'
WHERE last_name REGEXP 'field$'
```

| searches for multiple words(can be used together with ^ or $).
``` sql
SELECT *
FROM Customers
WHERE last_name REGEXP 'field$|^mac|rose'
```

[] provides a option of a series of letters.
``` sql
SELECT *
FROM Customers
WHERE last_name REGEXP '[gim]e'
-- to match ge, ie, me
```

[] can also represents a range of letters.
``` sql
SELECT *
FROM Customers
WHERE last_name REGEXP '[a-h]e'
-- [a-h] represents letter a to h
```

EXERCISE
``` sql
SELECT *
FROM Customers
WHERE first_name REGEXP 'elka|ambur'
-- WHERE last_name REGEXP 'ey$|on$'
-- WHERE last_name REGEXP '^my|se'
-- WHERE last_name REGEXP 'b[ru]'
```

## The IS NULL Operator
IS NULL: get missing values.IS NOT NULL has an opposite result.
``` sql
SELECT *
FROM Customers
WHERE phone IS NULL
```

EXERCISE
``` sql
SELECT *
FROM orders
WHERE shipped_id IS NULL
```

## The ORDER BY Clause
ORDER BY: default in increasing order, use DESC to obtain descending order.
``` sql
SELECT *
FROM customers
ORDER BY first_name DESC
```

Sort data by multiple columns. DESC can be used in any column.
``` sql
SELECT *
FROM customers
ORDER BY state DESC, first_name
```

MySQL can sort data by columns not necessarily in SELECT clause(may be wrong in other database systems).
``` sql
SELECT first_name, last_name
FROM customers
ORDER BY birth_date
```

Or sort data by alias(in MySQL)
``` sql
SELECT first_name, last_name, 10 + 1 AS points
FROM customers
ORDER BY points, first_name
```

Use number to indicates the columns(in the following examples, 1 indicates first_name, 2 indicates last_name(not recommended, easily affected by selected columns).
``` sql
SELECT first_name, last_name
FROM customers
ORDER BY 1, 2
```

EXERCISE
``` sql
SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC
```

## The LIMIT Clause
Limits the number of records returned from query
``` sql
SELECT *
FROM customers
LIMIT 3
```

Use offset to obtain a certain range of data.(In the following example, 6 is the offset, 3 is the number of records, getting records 7-9)
``` sql
SELECT *
FROM customers
LIMIT 6, 3
```

EXERCISE(notice the order of clauses, LIMIT clause should always be the last one).  
Correct order: SELECT-FROM-WHERE-ORDER BY-LIMIT
``` sql
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3
```
