# Chapter 11 Transcations

## Transcations
Transactions: A group of SQL statements that represent a single unit of work.
ACID properties:
1. **Atomicity**: Transactions are like atoms, unbreakable. Each transaction is a single unit work, no matter how many statements it contains. Either all these statements executed successfully and transaction is committed, or the transaction is rollback and all the changes are undone.
2. **Consistency**: With these transactions, database will always remain a consistent state.
3. **Isolation**: These transactions are isolated or protected with each other, if they try to modify the same data. They cannot interfere with each other. If multiple transactions want to modify the same data, the rows being affected get locked. Only one transactions at a time can update those rows. Other transaction have to wait for that transaction to complete.
4. **Durability**: Once a transaction is committed, the change made by the transaction is permanent.

## Creating Transactions
``` sql
USE sql_store;

START TRANSACTION;

INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-01', 1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 1);

COMMIT;
```
Use ROLLBACK to replace COMMIT: rollback the transaction and undo all the changes.

MySQL will commit statements automatically as long as it do not make errors.
``` sql
SHOW VARIABLES LIKE 'autocommit';
```

## Concurrency and Locking
Concurrency: Two or more users try to access the same data at the same time.
``` sql
USE sql_store;

START TRANSACTION;
UPDATE customers
SET points = points + 10
WHERE customer_id = 1;
COMMIT;
```
If a transaction try to modify a row or multiple rows, MySQL put a lock on these rows. These locks prevent other transactions from modifying these rows until the first transaction is done(committed or rollback).

## Concurrency Problems
1. Lost Updates: Two transactions try to update the same data and do not use locks. The transaction committed later will overwrite the changes made by the previous transaction.
2. Dirty Reads: A transaction reads the data that has not been committed yet. 
3. Non-repeating Reads(Inconsistent Reads): Read a data twice, but get different results.
4. Phantom Reads: Data suddenly appears, missed in query. Because it is updated, removed or deleted after the execution of query.

## Transaction Isolation Levels
Solutions:
|| Lost Updates | Dirty Reads | Non-repeating Reads | Phantom Reads |
|------------------|----------|----------|----------|----------|
| READ UNCOMMITTED |          |          |          |          |
| READ COMMITTED   |          | &#10004; |          |          |
| REPEATABLE READ  | &#10004; | &#10004; | &#10004; |          |
| SERIALIZABLE     | &#10004; | &#10004; | &#10004; | &#10004; |

SERIALIZABLE: Need extra resources, including memory and CPU to manage transactions that have to wait.  
The higher the isolation level, the more performance and scalability problem will experience(more locks involved to isolate transactions).
REPEATABLE READ: Default transaction isolation level in MySQL.

View the current isolation level:
``` sql
SHOW VARIABLES LIKE 'transaction_isolation';
```

Set new isolation level:
``` sql
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET GLOBAL TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

## READ UNCOMMITTED Isolation Level
``` sql
USE sql_store;

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SELECT points
FROM customers
WHERE customer_id = 1;
```

``` sql
USE sql_store;

START TRANSACTION;
UPDATE customers
SET points = 20
WHERE customer_id = 1;
COMMIT;
```
READ UNCOMMITTED: lowest isolation level, may meet all concurrency problems.

## READ COMMITTED Isolation Level
``` sql
USE sql_store;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
SELECT points FROM customers WHERE customer_id = 1;
SELECT points FROM customers WHERE customer_id = 1;
COMMIT;
```

``` sql
USE sql_store;

START TRANSACTION;
UPDATE customers
SET points = 20
WHERE customer_id = 1;
COMMIT;
```

## REPEATABLE READ Isolation Level
Repeatable and consistent
``` sql
USE sql_store;

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
START TRANSACTION;
SELECT * FROM customers WHERE state = 'VA';
COMMIT;
```

``` sql
USE sql_store;

START TRANSACTION;
UPDATE customers
SET state = 'VA'
WHERE customer_id = 1;
COMMIT;
```

## SERIALIZABLE Isolation Level
SERIALIZABLE Isolation Level: Transactions are executed in sequence. It is like a single-user system, one user executing different commands against the database. These commands are executed sequentially.
``` sql
USE sql_store;
SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
START TRANSACTION;
SELECT *
FROM customers
WHERE state = 'VA';
COMMIT;
```

``` sql
USE sql_store;

START TRANSACTION;
UPDATE customers
SET state = 'VA'
WHERE customer_id = 3;
COMMIT;
```

## Deadlocks
Deadlocks: happen when different transactions cannot complete because each transaction holds a lock that other needs. So both transactions keeps waiting for each other and never release their lock.
``` sql
USE sql_store;
START TRANSACTION;
UPDATE customers SET state = 'VA' WHERE customer_id = 1;
UPDATE orders SET status = 1 WHERE order_id = 1;
COMMIT;
```
Error 1213: Deadlock found when ...
