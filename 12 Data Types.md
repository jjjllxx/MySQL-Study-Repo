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
