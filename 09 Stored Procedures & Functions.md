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
Use procedures to insert, update and delete data.
``` sql
CREATE PROCEDURE make_payment
(
    invoice_id INT,
    payment_amount DECIMAL(9, 2),
    -- 9 represents the total number of digits, 2 represents number of digits after decimal point
    payment_date DATE
)
BEGIN
    UPDATE invoices i
    SET
	i.payment_total = payment_amount,
        i.payment_date = payment_date
    WHERE i.invoice_id = invoice_id;
END
```

Click on the flash button to call the procedure
``` sql
call sql_invoicing.make_payment(2, 100, '2019-01-01');
```

Validate parameter: for example, payment_total should not be negative.  
SIGNAL SQLSTATE: throw an error(search *sqlstate errors* for more information).  
``` sql
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_payment`(
	invoice_id INT,
    payment_amount DECIMAL(9, 2),
    -- 9 represents the total number of digits, 2 represents number of digits after decimal point
    payment_date DATE
)
BEGIN
    IF payment_amount <= 0 THEN
        SIGNAL SQLSTATE '22003'
	SET MESSAGE_TEXT = 'Invalid payment amount';
    END IF;
    
    UPDATE invoices i
    SET
	i.payment_total = payment_amount,
        i.payment_date = payment_date
    WHERE i.invoice_id = invoice_id;
END
```

## Output Parameters
``` sql
CREATE PROCEDURE get_unpaid_invoices_for_clients
(
    client_id INT
)
BEGIN
    SELECT 
	COUNT(*),
        SUM(invoice_total)
    FROM invoices i
    WHERE i.client_id = client_id
	AND payment_total = 0;
END
```

Generated code
``` sql
call sql_invoicing.get_unpaid_invoices_for_clients(3)
```
OUT: mark parameters as output parameters.   
INTO: read values and copy to output parameters.  
``` sql
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_unpaid_invoices_for_clients`(
    client_id INT,
    OUT invoices_count INT,
    OUT invoices_total DECIMAL(9, 2)
)
BEGIN
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id
	AND payment_total = 0;
END
```

Same output, but generated code:
``` sql
set @invoices_count = 0;
set @invoices_total = 0;
call sql_invoicing.get_unpaid_invoices_for_clients(3, @invoices_count, @invoices_total);
select @invoices_count, @invoices_total;
```

## Variables
User or session variables: defined with SET statement and prefix with @.
``` sql
set @invoices_count = 0;
```

Local variables: defined inside stored procedures or functions. Not stored in memory for the entire user session.  
risk_factor is a local variable in the following example.
``` sql
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_risk_factor`()
BEGIN
    DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices;
    
    SET risk_factor = invoices_total / invoices_count * 5;
    
    SELECT risk_factor;
END
```

## Functions
Like built-in functions, this part is about creating own functions. Functions are like procedures, but only return a single value.
Right click on Functions to create a new function.
Set the attribute of function(every MySQL function should have at least one(can be more than one) attribute):
1. DETERMINSTIC: If given same set of values, always return same value.
2. READS SQL DATA: Function has SELECT statement to read some data.
3. MODIFIES SQL DATA: Function has INSERT, UPDATE or DELETE statement.
``` sql
CREATE DEFINER=`root`@`localhost` FUNCTION `get_risk_factor_for_client`(
    client_id INT
) 
RETURNS int
READS SQL DATA
BEGIN
    DECLARE risk_factor DECIMAL(9, 2) DEFAULT 0;
    DECLARE invoices_total DECIMAL(9, 2);
    DECLARE invoices_count INT;
    
    SELECT COUNT(*), SUM(invoice_total)
    INTO invoices_count, invoices_total
    FROM invoices i
    WHERE i.client_id = client_id;
    
    SET risk_factor = invoices_total / invoices_count * 5;
RETURN IFNULL(risk_factor, 0);
END
```

Use functions(just like the built-in)
``` sql
SELECT 
    client_id,
    name,
    get_risk_factor_for_client(client_id) AS risk_factor
FROM clients
```

Drop functions
``` sql
DROP FUNCTION IF EXISTS get_risk_factor_for_client
```

## Other Conventions
Follow company conventions or teammates.
