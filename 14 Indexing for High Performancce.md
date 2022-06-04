# Chapter 14 Indexing for High Performancce

## Introduection
Indexes speed up our queries.   
Use [load_1000_customers](https://github.com/JinLexuan/MySQL-study-repo/blob/main/SQL%20Course%20Materials/load_1000_customers.sql) to load 1000 customers' information.

## Indexes
Indexes: basically a kind of data structure that databases use to quicklty find data.  
Cost of Indexes
1. Increase the database
2. Slow down the writes
Reserve indexes for performance critical queries. Design indexes based on your queries, not tables.

## Creating Indexes
EXPLAIN query
``` sql
EXPLAIN SELECT customer_id FROM customers WHERE state = 'CA';
```
type: ALL means it scan/read all the records in the table.  
rows: the number of records it scanned.  

Create indexes(prefix with idx):
``` sql
CREATE INDEX idx_state ON customers (state);
```
EXPLAIN the query
1. type changes from ALL to ref. 
2. rows changes from 1010 to 112. 
3. possible_keys: idx_state
4. key: idx_state

EXERCISE
``` sql
EXPLAIN SELECT customer_id FROM customers WHERE points > 1000;
CREATE INDEX idx_points ON customers (points)
```
type: range

## Viewing Indexes
``` sql
SHOW INDEXES IN customers;
```
Primary Key: Clustered Index. 
Indexes created by user: Secondary indexes.  
collation: how data is sorted. A is ascending, D is descending.
index_type: BTREE, shorted for binary tree.  
  
Analyse table, then SHOW INDEXES will have more accurate value:
``` sql
ANALYZE TABLE customers;
```

## Prefix Indexes

