# Chapter 08 Views

## Creating Views
Save queries or subqueries in the view to simplify SELECT statements. View can be used as table.
``` sql
USE sql_invoicing;

CREATE VIEW  sales_by_client AS
SELECT
    c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name
```

EXERCISE
``` sql
USE sql_invoicing;

CREATE VIEW clients_balance AS
SELECT
    c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name
```

## Altering or Dropping Views
DROP old views then create new ones
``` sql
DROP VIEW sales_by_client
```

REPLACE: do not need to delete view in advance
``` sql
USE sql_invoicing;

CREATE OR REPLACE VIEW clients_balance AS
SELECT
    c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balance
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name
```

## Updatable Views
Updatable views: do not have DISTINCT, Aggregate Functions(MIN, MAX, SUM), GROUP BY/HAVING, UNION.  
UPDATE, DELETE, INSERT can be used in updatable views.
``` sql
USE sql_invoicing;

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT
    invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
```

DELETE
``` sql
DELETE FROM invoices_with_balance
WHERE invoice_id = 1
```

UPDATE
``` sql
UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2
```

## The WITH OPTION CHECK Clause
WITH CHECK OPTION: prevent UPDATE or DELETE statement from excluding rows from the view(get an error).
``` sql
USE sql_invoicing;

CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT
    invoice_id,
    number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION
```

## Other Benefits of Views
1. Simplify queries
2. Reduce the impact of changes
3. Restrict access to the data
