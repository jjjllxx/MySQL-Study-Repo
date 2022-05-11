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
