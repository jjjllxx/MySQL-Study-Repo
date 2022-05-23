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

```
Search *mysql string function* for complete list

## Date Functions
