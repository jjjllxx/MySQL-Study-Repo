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
