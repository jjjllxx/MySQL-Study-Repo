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

``` sql
```
