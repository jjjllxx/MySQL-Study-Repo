# Chapter 12 Data Type
## Introduction
MySQL Data Types
1. String Types
2. Numeric Types
3. Date and Time Types
4. Blob Types: store binary data.
5. Spatial Types: store geometric or geographical values.

## String Types
Strings    
1. CHAR(x): fixed-length.  
2. VARCHAR(x): variable-length strings. Usernames, passwords, e-mails and addresses. max: 65535 characters(~64KB).  
They can also store numeric values(zipcode, phone numbers), because they are not involved in mathematical operations or hyphen is involved.
To simplify the maintainence of databases: VARCHAR(50) for short-length strings. VARCHAR(255) for medium-length strings.  
3. MEDIUMTEXT: max: 16MB.
4. LONGTEXT: max: 4GB.
5. TINYTEXT: max: 255 bytes.
6. TEXT: max: 64KB.

BYTES:  
English: 1.  
European/Middle-eastern:2.  
Asian: 3   
MySQL leaves 30 bytes for CHAR(10).

## Integer Types
| Type | Storage(Bytes) | Value Range | 
|---------|----------|----------|
| TINYINT            | 1b | [-128, 127] |
| UNSIGNED TINYINT   | 1b | [0, 255]    |
| SMALLINT           | 2b | [-32K, 32K] |
| MEDIUMINT          | 3b | [-8M, 8M]   |
| INT                | 4b | [-2B, 2B]   | 
| BIDINT             | 8b | [-9Z, 9Z]   |

Search *mysql integer types* for more information.  
If trying to store a value out of range, MySQL will throw out an error: value is out of range.  
ZEROFILL: Use zeros to pad the value, so numbers have same number of digits. INT(4) => 0001.  
Use the smallest data type that suits your needs. Database will be smaller in size, queries will be executed faster.  

## Fixed-point and Floating-point Types
RATIONALS
1. DECIMAL(p, s) DECIMAL(9, 2) => 1234567.89   Alias: DEC, NUMERIC, FIXED
2. FLOAT 4b
3. DOUBLE 8b. This two store approximation instead of exact value.

## Boolean Types
BOOL / BOOLEAN: 1/0 can replace TRUE/FALSE.
``` sql
UPDATE posts
SET is_published = TRUE  # or FALSE
```

## Enum and Set Types
ENUM('small', 'medium', 'large')
Add an ENUM column
``` sql
ALTER TABLE `sql_store`.`products` 
ADD COLUMN `size` ENUM('small', 'medium', 'lagre') NULL AFTER `unit_price`;
```

Change an ENUM value
``` sql
UPDATE `sql_store`.`products` SET `size` = 'small' WHERE (`product_id` = '1');
```

SET(...)

## Date and Time Types
DATE/TIME
| Type | Remark |
|---------|----------|
| DATE   | A date without time component |
| TIME   | A time value|
| DATETIME  | 8b |
| TIMESTAMP | 4b (up to 2038) 'year 2038 problem'|
| YEAR      | A 4-digits year | 

## Blob Types
| Type | Storage(Bytes) |
|---------|----------|
| TINYBLOB   | 255b |
| BLOB       | 65KB |
| MEDIUMBLOB | 16MB |
| LONGBLOB   | 4GB  |

Problems with Storing Files in a Database
1. Increased database size
2. Slower backups
3. Performance problems
4. More code to read/write images

## JSON Types
JSON: Lightweight format for storing and transferring data over the internet. {'key': value}
Build a column with JSON
``` sql
ALTER TABLE `sql_store`.`products` 
ADD COLUMN `properties` JSON NULL AFTER `size`;
```

Two ways to set JSON value
``` sql
USE sql_store;
UPDATE products
SET properties = '
{
    "dimensions" : [1, 2, 3],
    "weight" : 10,
    "manufacturer" : { "name": "sony" }
}
'
WHERE product_id = 1;
```

``` sql
USE sql_store;
UPDATE products
SET properties = JSON_OBJECT(
    'weight', 10,
    'dimensions', JSON_ARRAY(1, 2, 3),
    'manufacturer', JSON_OBJECT('name', 'sony')
)
WHERE product_id = 1;
```

Obtain JSON value
``` sql
SELECT product_id, JSON_EXTRACT(properties, '$.weight') AS weight
FROM products
WHERE product_id = 1;
```

``` sql
SELECT product_id, properties -> '$.weight' AS weight
FROM products
WHERE product_id = 1;
```

Get a value of certain index in a JSON array(index starts with 0)
``` sql
SELECT product_id, properties -> '$.dimensions[1]'
FROM products
WHERE product_id = 1;
```

Obtain JSON in JSON(two greater-than sign to get rid of quotes of strings)
``` sql
SELECT product_id, properties ->> '$.manufacturer.name'
FROM products
WHERE product_id = 1;
```

``` sql
SELECT product_id, properties ->> '$.manufacturer.name'
FROM products
WHERE properties ->> '$.manufacturer.name' = 'sony';
```

JSON_SET: update some of JSON values or add new ones
``` sql
USE sql_store;
UPDATE products
SET properties = JSON_SET(
    properties,
    '$.weight', 20,
    '$.age', 10
)
WHERE product_id = 1;
```

JSON_REMOVE: delete one or more properties
``` sql
USE sql_store;
UPDATE products
SET properties = JSON_REMOVE(
    properties,
    '$.age'
)
WHERE product_id = 1;
```
