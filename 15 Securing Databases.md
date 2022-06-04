# Chapter 15 Securing Databases

## introduction

## Creating a User
Ip address
``` sql
CREATE USER john@127.0.0.1
```

Hostname
``` sql
CREATE USER john@localhost
```

Domain name
``` sql
CREATE USER john@'%.codewithmosh.com'
```

No restriction and set password
``` sql
CREATE USER john IDENTIFIED BY '1234';
```

## View Users
``` sql
SELECT * FROM mysql.user;
```
Or on the left side -> open Administration -> Users and Privileges

## Dropping Users
``` sql
CREATE USER bob@codewithmosh.com IDENTIFIED BY '1234';
DROP USER bob@codewithmosh.com;
```

## Changing Passwords
For a certain user:
``` sql
SET PASSWORD FOR john = '1234';
```

For current user:
``` sql
SET PASSWORD = '1234';
```
Or on the left side -> open Administration -> Users and Privileges ->change/expire password -> apply

## Granting Privileges
1: web/desktop application
``` sql
CREATE USER moon_app IDENTIFIED BY '1234';
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE
ON sql_store.*
TO moon_app;
```

Search *mysql privileges*
2: admin
``` sql
GRANT ALL
ON *.* -- all databases and all tables
TO john
```

## Viewing Privileges
For a certain user:
``` sql
SHOW GRANTS FOR john;
```

For current user
``` sql
SHOW GRANTS;
```
Or on the left side -> open Administration -> Users and Privileges -> Administrative Roles/Schema Privileges

## Dropping Privileges
``` sql
REVOKE CREATE VIEW
ON sql_store.*
FROM moon_app;
```
Take security seriously, always grant the minimum required for user account.
