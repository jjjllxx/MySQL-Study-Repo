# Chapter 13b Designing Databases(Projects)

## Project: Flight Booking Syste
[ch.13-PROJECT Flight Booking System](https://github.com/JinLexuan/MySQL-study-repo/blob/main/SQL%20Course%20Materials/ch.13-PROJECT%20Flight%20Booking%20System.pdf)

### Solutions: Conceptual Model
<img width="633" alt="image" src="https://user-images.githubusercontent.com/60777462/171800340-18746b1a-a3b2-4f25-a4c9-397eb46e9c50.png">

### Solutions: Logical Model
<img width="653" alt="image" src="https://user-images.githubusercontent.com/60777462/171806189-b246c65c-7fc7-4b2e-9753-c61f1c8584cf.png">

## Project: Radio Rental Application
[ch13-PROJECT Video Rental Application](https://github.com/JinLexuan/MySQL-study-repo/blob/main/SQL%20Course%20Materials/ch13-PROJECT%20Video%20Rental%20Application.pdf)

### Solutions: Conceptual Model
<img width="468" alt="image" src="https://user-images.githubusercontent.com/60777462/171811074-45234823-b709-45a8-9798-95869a811cfa.png">

### Solutions: Logical Model
<img width="460" alt="image" src="https://user-images.githubusercontent.com/60777462/171813203-dd74f37d-5807-4228-9c07-f451c8dcb073.png">

## Creating Databases
Create
``` sql
CREATE DATABASE IF NOT EXISTS sql_store2;
```

Delete
``` sql
DROP DATABASE IF EXISTS sql_store2;
```

## Creating Tables
``` sql
CREATE DATABASE IF NOT EXISTS sql_store2;
USE sql_store2;
DROP TABLE IF EXISTS customers;
CREATE TABLE IF NOT EXISTS customers 
(
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(50) NOT NULL,
    points      INT NOT NULL DEFAULT 0,
    email       VARCHAR(255) NOT NULL UNIQUE
);

```

## Altering Tables
``` sql
ALTER TABLE customers
    ADD last_name VARCHAR(50) NOT NULL AFTER first_name,
    ADD city      VARCHAR(50) NOT NULL,
    MODIFY COLUMN first_name VARCHAR(55) DEFAULT '',
    DROP points;
```

## Creating Relationships
``` sql
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
	order_id    INT PRIMARY KEY,
    customer_id INT NOT NULL,
    FOREIGN KEY fk_orders_customers (customer_id)
	    REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
```

## Altering Primary/Foreign Key
``` sql
ALTER TABLE orders
	ADD PRIMARY KEY (order_id),
    DROP PRIMARY KEY,
	DROP FOREIGN KEY fk_orders_customers,
    ADD FOREIGN KEY fk_orders_customers (customer_id)
		REFERENCES customers (customer_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
```

## Character Sets and Collations
Character set: A table that map each character to number.  
``` sql
SHOW CHARSET
```

Sometimes need change the character sets size for a smaller storage size. Example(database/table/column):
``` sql
ALTER DATABASE db_name CHARACTER SET latin1;
    
ALTER TABLE table1 CHARACTER SET latin1;

CREATE TABLE IF NOT EXISTS customers 
(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(50) CHARACTER SET latin1 NOT NULL,
    points 		INT NOT NULL DEFAULT 0,
    email		VARCHAR(255) NOT NULL UNIQUE
);
```

## Storage Engines
MylSAM for previous version database(5.5 and earlier). InnoDB for current version. 
``` sql
SHOW ENGINES
```

Change engine:
``` sql
ALTER TABLE customers
ENGINE = InnoDB
```
