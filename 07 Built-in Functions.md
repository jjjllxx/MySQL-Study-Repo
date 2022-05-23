# Chapter 07 Built-in Functions

## Numeric Functions
ROUND: rounding, can set keep how many bits of decimal(default: 0)
``` sql
SELECT ROUND(5.73, 1)
```

TRUNCATE:cut the number by bit, bit is compulsory
``` sql
SELECT TRUNCATE(5.7345, 0);
```

CEILING: smallest integer larger than or equal to this number, do not need bits
``` sql
SELECT CEILING(5.7345)
```

FLOOR: largest integer smaller than or equal to this number, do not need bits
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
``` sql
```
