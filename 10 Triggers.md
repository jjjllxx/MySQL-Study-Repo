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
Use create-payment-table file in the SQL Course Materials folder to create table payment_audit.  
Operate on two triggers: payment_after_insert, payment_after_delete.
``` sql
DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_insert;

CREATE TRIGGER payments_after_insert
    AFTER INSERT ON payments
    FOR EACH ROW
BEGIN
    UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (NEW.client_id, NEW.date, NEW.amount, 'Insert', NOW());
END $$

DELIMITER ;
```

``` sql
DELIMITER $$

DROP TRIGGER IF EXISTS payments_after_delete;

CREATE TRIGGER payments_after_delete
    AFTER DELETE ON payments
    FOR EACH ROW
BEGIN
    UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
    
    INSERT INTO payments_audit
    VALUES (OLD.client_id, OLD.date, OLD.amount, 'Delete', NOW());
END $$

DELIMITER ;
```

INSERT operation, record will show in payment_audit table.
``` sql
INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01', 10, 1)
```

DELETE operation, record will show in payment_audit table.
``` sql
DELETE FROM payments
WHERE payment_id = 10
```
<img width="359" alt="image" src="https://user-images.githubusercontent.com/60777462/170195958-8369c1ad-f151-4c49-b474-1b5def0e7396.png">

## Events
Events: A task (or block of SQL code) that gets executed according to a schedule. AUTOMATION
SHOW VARIABLES: all the system variables in MySQL. Set event_scheduler ON.
``` sql
SHOW VARIABLES LIKE 'event%';
SET GLOBAL event_scheduler = ON
```

Usually starts the event name with interval.  
AT: event happens once. EVERY: event happens every set interval.
STARTS: begin from when. ENDS: end at when.
``` sql
DELIMITER $$

CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULE
    -- AT '2019-05-01'
    EVERY 1 YEAR STARTS '2019-01-01' ENDS '2029-01-01'
DO BEGIN
    DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$

DELIMITER ;
```

## Viewing and Dropping Events
SHOW EVENTS: to show events, filter by LIKE.
``` sql
SHOW EVENTS;
```

DROP EVENT
``` sql
DROP EVENT IF EXISTS yearly_delete_stale_audit_rows;
```

ALTER EVENT: alter events without dropping it(same syntax with CREATE EVENT). Can also ENABLE or DISABLE an event temporarily.
```
ALTER EVENT yearly_delete_stale_audit_rows DISABLE
```
