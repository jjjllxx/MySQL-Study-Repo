# Chapter 10 Triggers

## Triggers
Triggers: A block of SQL code that automatically gets executed before or after an INSERT, UPDATE or DELETE statement.  
Use triggers to enforce data consistency.
``` sql
DELIMITER $$

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$

DELIMITER ;
```

To trigger the trigger:
``` sql
INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01', 10, 1)
```

EXERCISE
``` sql
DELIMITER $$

CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$

DELIMITER ;
```

``` sql
SELECT * FROM sql_invoicing.payments;

DELETE
FROM payments
WHERE payment_id = 10
```

## Viewing Triggers
SHOW TRIGGERS: see all the triggers visually.
``` sql
SHOW TRIGGERS
```

Filter triggers
``` sql
SHOW TRIGGERS LIKE 'payment%'
```

## Dropping Triggers
Usually drop triggers before create one.
``` sql
DROP TRIGGER IF EXISTS payment_after_insert
```

## Using Triggers for Auditing
