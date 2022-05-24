# Chapter 09 Stored Procedures & Functions

## Stored Procedures
Aim: Seperate SQL code with other programming language(C#, JAVA, Python) codes.  
Stored Procedures: A database object contains a block of SQL code. In application code, call these procedures to get or save the data.
Advantages:
1. Store and organize SQL.
2. Faster execution.
3. Data security.

## Creating a Stored Procedure
In-between the BEGIN and END keyword is the body of the stored procedure.  
DELIMITER: change the default delimiter(usually use $$).   
In other DBMS, like SQL server, it is not necessary to change the default delimiter.
``` sql
DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
    SELECT * FROM clients;
END $$

DELIMITER ;
```

Click the lightning button or use CALL clause to call the stored procedure.
``` sql
CALL get_clients()
```

EXERCISE
``` sql
DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
    SELECT * FROM invoices
    WHERE (invoice_total - payment_total) > 0;
END $$

DELIMITER ;
```

## Creating Procedures Using MySQLWorkbench
Right click Stored Procedures in MySQLWorkbench. MySQL uses backticks by default to prevent name clash with SQL keyword.  
``` sql
CREATE PROCEDURE `get_payments` ()
BEGIN
    SELECT * FROM payments;
END
```

Click on Apply button. The following code will generate automatically.
``` sql
USE `sql_invoicing`;
DROP procedure IF EXISTS `get_payments`;

DELIMITER $$
USE `sql_invoicing`$$
CREATE PROCEDURE `get_payments` ()
BEGIN
    SELECT * FROM payments;
END $$

DELIMITER ;
```

## Dropping Procedures
DROP PROCEDURE + name of an existing procedure. If procedure does not exist, an error will happen.
``` sql
DROP PROCEDURE get_clients
```

IF EXISTS: a safer way to drop procedures.
``` sql
DROP PROCEDURE IF EXISTS get_clients
```

Basic template to creating procedures: drop first then create.
``` sql
DROP PROCEDURE IF EXISTS get_clients;

DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
    SELECT * FROM clients;
END $$

DELIMITER ;
```

## Parameters with Default Values
IF is ended with END IF clause and semicolon.
``` sql
DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
    state CHAR(2)
)
BEGIN
    IF state IS NULL THEN
        SET state = 'CA';
    END IF;
    SELECT * FROM clients c
    WHERE c.state = state;
END $$

DELIMITER ;
```

``` sql
CALL get_clients_by_state(NULL)
```

Return all the clients instead of only in CA. 
Method 1:
``` sql
DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
    state CHAR(2)
)
BEGIN
    IF state IS NULL THEN
        SELECT * FROM clients;
    ELSE
	    SELECT * FROM clients c
        WHERE c.state = state;
    END IF;
END $$

DELIMITER ;
```

``` sql
CALL get_clients_by_state('CA')
```

Method 2: combine two queries into a single one
``` sql
DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
    state CHAR(2)
)
BEGIN
    SELECT * FROM clients c
    WHERE c.state = IFNULL(state, c.state);
END $$

DELIMITER ;
```

EXERCISE
``` sql
DROP PROCEDURE IF EXISTS get_payments;

DELIMITER $$
CREATE PROCEDURE get_payments
(
	client_id INT,
    payment_method_id TINYINT
)
BEGIN
	SELECT *
    FROM payments p
    WHERE 
		p.client_id = IFNULL(client_id, p.client_id) AND 
        p.payment_method = IFNULL(payment_method_id, p.payment_method);
END $$

DELIMITER ;
```

NULL can be a certain number to get specific client_id or payment_method_id record. If both arguments is NULL, then get all the records.
``` sql
CALL get_payments(NULL, NULL)
```

## Parameter Validation
``` sql
```
