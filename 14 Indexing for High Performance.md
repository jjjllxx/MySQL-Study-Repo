# Chapter 14 Indexing for High Performance

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
For String Columns(CHAR, VARCHAR, TEXT, BLOB), use first several characters instead of all the column as the index.
``` sql
CREATE INDEX idx_lastname ON customers (last_name(20));
```

To find the optimal length of index:
``` sql
SELECT
	COUNT(DISTINCT LEFT(last_name, 1)),
    COUNT(DISTINCT LEFT(last_name, 5)),
    COUNT(DISTINCT LEFT(last_name, 10))
FROM customers;
```

## Full-text Indexes
Use [create-db-blog](https://github.com/JinLexuan/MySQL-study-repo/blob/main/SQL%20Course%20Materials/create-db-blog.sql) to create sql_blog.  
Traditional Method
``` sql
USE sql_blog;
SELECT *
FROM posts
WHERE title LIKE '%react redux%' OR
	body LIKE '%react redux%';
```

FULLTEXT INDEX(Nature Language Mode):
``` sql
CREATE FULLTEXT INDEX idx_title_body ON posts (title, body);

SELECT *, MATCH(title, body) AGAINST ('react redux')
FROM posts
WHERE MATCH(title, body) AGAINST ('react redux');
```
The repeat of MATCH shows the relevance score, a float between 0 to 1, higher score means more relevant.

FULLTEXT INDEX(Boolean Mode):
``` sql
SELECT *, MATCH(title, body) AGAINST ('react redux')
FROM posts
WHERE MATCH(title, body) AGAINST ('react -redux +form' IN BOOLEAN MODE);
```
Minus sign: exclude some words. Plus sign: must have some words. Double quotes: find exact phrase.  

## Composite Indexes
``` sql
USE sql_store;
SHOW INDEXES IN customers;
EXPLAIN SELECT customer_id FROM customers
WHERE state = 'CA' AND points > 1000
```
MySQL will take only one index.  

Composite Indexes:
``` sql
USE sql_store;
CREATE INDEX idx_state_points ON customers (state, points);
EXPLAIN SELECT customer_id FROM customers
WHERE state = 'CA' AND points > 1000
```
MySQL maximum index column: 16.

DROP INDEX
``` sql
DROP INDEX idx_state ON customers;
DROP INDEX idx_points ON customers;
```

## Order of Columns in Composite Indexes
Order of Columns:
1. Put the most frequently used column first.
2. Put the columns with a higher cardinality first. Cardinality represents the number of unique number in the index.  
3. Consider order according to practical situation.

Use a certain index;
``` sql
SELECT customer_id
FROM customers
USE INDEX (idx_lastname_state)
WHERE state = 'NY' AND last_name LIKE 'A%'
```

## When indexes are ignored
