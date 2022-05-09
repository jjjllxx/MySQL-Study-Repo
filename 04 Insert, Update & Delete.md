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
``` sql
```
