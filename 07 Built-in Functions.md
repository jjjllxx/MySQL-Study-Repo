# Chapter 07 Built-in Functions

## Numeric Functions
ROUND: rounding, can set keep how many bits of decimal(the second argument is optional, default: 0)
``` sql
SELECT ROUND(5.73, 1)
```

TRUNCATE:cut the number by bit, the second argument is compulsory
``` sql
SELECT TRUNCATE(5.7345, 0);
```

CEILING: smallest integer larger than or equal to this number, only one argument
``` sql
SELECT CEILING(5.7345)
```

FLOOR: largest integer smaller than or equal to this number, only one argument
``` sql
SELECT FLOOR(5.7345)
```

ABS: calculate absolute value
``` sql
SELECT ABS(-5.7345)
```

RAND: generate a random floating number between 0-1
``` sql
SELECT RAND()
```
Search *mysql numeric function* for complete list

## String Functions
LENGTH: calculate the length of string
``` sql
SELECT LENGHT('sky')
```

UPPER/LOWER: transfer string into upper/lower case
``` sql
SELECT UPPER('sky')
```

LTRIM/RTRIM: trim extra spaces from the left/right.  
TRIM: delete any leading or trailing spaces. 
``` sql
SELECT LTRIM('   Sky.  ')
```

LEFT/RIGHT: get the first several letters from left/right  
``` sql
SELECT LEFT('Kindergarten', 4)
```

SUBSTRING: get a part of the string, the second argument is the start position, the third argument is the length.  
The third argument is optional.
``` sql
SELECT SUBSTRING('Kindergarten', 3, 6)
```

LOCATE: find the first matched string position.(index starts from 1, result 0 means cannot find, case insensitive)
``` sql
SELECT LOCATE('der', 'Kindergarten')
```

REPLACE: find a substring and replace it with an expected string
``` sql
SELECT REPLACE('kindergarten', 'garten', 'garden')
```

CONCAT: concat two strings
``` sql
USE sql_store;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers
```
Search *mysql string function* for complete list

## Date Functions
NOW(): current date and time. CURDATE(): only current date. CURTIME(): only current time.
``` sql
SELECT NOW(), CURDATE(), CURTIME()
```

YEAR(), MONTH(), DAY(), HOUR(), MINUTE(), SECOND(): combine with a time to get year, month, hour, minute or second of it. Only returns integer.
``` sql
SELECT YEAR(NOW())
```

DAYNAME(): to get the day of the week. MONTHNAME(): to get the name of the month.
``` sql
SELECT DAYNAME(NOW())
```

EXTRACT()
``` sql
SELECT EXTRACT(YEAR FROM NOW())
```

EXERCISE
``` sql
SELECT *
FROM orders
WHERE YEAR(order_date) = YEAR(NOW())
```

## Formatting Dates and Times
DATE_FORMAT(): m d y can be either upper case or lower case.
``` sql
SELECT DATE_FORMAT(NOW(), '%M %D %Y')
```

TIME_FORMAT() 
``` sql
SELECT TIME_FORMAT(NOW(), '%H:%i %p')
```
Search *mysql date format function* for more information

## Calculating Dates and Times
DATE_ADD(): add time interval, number can be negative value(like DATE_SUB()).  
DATE_SUB(): subtract time interval.
``` sql
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY)
```

DATEDIFF(): calculate the difference between two dates
``` sql
SELECT DATEDIFF('2019-01-05 09:00', '2019-01-01 11:00')
```

TIME_TO_SEC(): transfer time to seconds
``` sql
SELECT TIME_TO_SEC('9:00') - TIME_TO_SEC('09:02')
```

## The IFNULL and COALESCE Functions
IFNULL: substitute null value with something else
``` sql
USE sql_store;

SELECT 
    order_id,
    IFNULL(shipper_id, 'Not assigned') AS shipper
FROM orders 
```

COALESCE: supply a list of value, return the first not null value.  
``` sql
USE sql_store;

SELECT 
    order_id,
    COALESCE(shipper_id, comments, 'Not assigned') AS shipper
FROM orders 
```

EXERCISE
``` sql
USE sql_store;

SELECT 
    CONCAT(first_name, ' ', last_name) AS customer,
    IFNULL(phone, 'unknow') AS phone
FROM customers
```

## The IF Function
IF(expression, first, second): if the expression is true, return the first, otherwise return the second.
``` sql
USE sql_store;

SELECT 
    order_id,
    order_date,
    IF(YEAR(order_date) = YEAR(NOW()), 'Active', 'Archived') AS category
FROM orders
```

EXERCISE
``` sql
USE sql_store;

SELECT
    product_id,
    name,
    COUNT(*) AS orders,
    IF(COUNT(*) > 1, 'Many times', 'Once') AS frequency
FROM products
JOIN order_items USING (product_id)
GROUP BY product_id
```

## The CASE operator
CASE: for multiple situations
``` sql
USE sql_store;

SELECT
    order_id,
    CASE
	WHEN YEAR(order_date) = YEAR(NOW()) - 3 THEN 'Active'
        WHEN YEAR(order_date) = YEAR(NOW()) - 4 THEN 'Last Year'
        WHEN YEAR(order_date) < YEAR(NOW()) - 4 THEN 'Archived'
        ELSE 'Future'
    END AS category
FROM orders
```

EXERCISE
``` sql
USE sql_store;

SELECT
    CONCAT(first_name, ' ', last_name) AS customer,
    points,
    CASE
	WHEN points > 3000 THEN 'Gold'
        WHEN points >= 2000 THEN 'Silver'
        ELSE 'Bronze'
    END AS category
FROM customers
ORDER BY points DESC
```
