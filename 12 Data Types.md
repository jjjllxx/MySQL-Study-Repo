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

