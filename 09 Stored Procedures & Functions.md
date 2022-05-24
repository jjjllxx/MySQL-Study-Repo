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
END$$

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
END$$

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
END$$

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
END$$

DELIMITER ;
```

## Parameters with Default Values

