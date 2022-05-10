# 04 Insert, Update & Delete
## Column Attributes
Click on the middle button(wrench) after the table name for the following interface.
<img width="1120" alt="image" src="https://user-images.githubusercontent.com/60777462/167370604-d064914f-7570-425a-b2c2-5d211f343814.png">

## Inserting a Single Row
``` sql
INSERT INTO customers
VALUES (
    DEFAULT,
    'John',
    'Smith',
    '1990-01-01',
    NULL,
    'address',
    'city',
    'CA',
    DEFAULT
)
```

Order of columns can be changed.
``` sql
INSERT INTO customers (
    first_name,
    last_name,
    birth_date,
    address,
    city,
    state
)
VALUES (
    'John',
    'Smith',
    '1990-01-01',
    'address',
    'city',
    'CA'
)
```
Response(1 row(s) affected)

## Inserting Multiple Rows
``` sql
INSERT INTO shippers(name)
VALUES ('Shipper1'),
       ('Shipper2'),
       ('Shipper3')
```

EXERCISE
``` sql
INSERT INTO products (name, quantity_in_stock, unit_price)
VALUES ('Product1', 10, 1.95),
       ('Product2', 11, 1.95),
       ('Product1', 12, 1.95)
```

## Inserting Hierarchical Rows
Insert data into multiple tables.  
LAST_INSERT_ID()
``` sql
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES 
    (LAST_INSERT_ID(), 1, 1, 2.95),
    (LAST_INSERT_ID(), 2, 1, 3.95)
```

## Creating a Copy of a Table
Mysql will ignore some attributes(Primary Key, Auto Increment) when copy. This is shown in Design Mode.
The name of new table should be different from existing ones.
``` sql
CREATE TABLE orders_archived AS
SELECT * FROM orders
```

Truncate: delete all the data in a table, but keep the table.

EXERCISE
``` sql
USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT
    invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
    USING (client_id)
WHERE payment_date IS NOT NULL
```

## Updating a Single Row
``` sql
UPDATE invoices
SET payment_total = 10, payment_date = '2019-03-01'
WHERE invoice_id = 1
```

Values can be an expression
``` sql
UPDATE invoices
SET 
    payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE invoice_id = 3
```

## Updating Multiple Rows
``` sql
```
