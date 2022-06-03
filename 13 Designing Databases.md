# Chapter 13 Designing Databases

## Introduction

## Data Modelling
Data Modelling
1. Understand the requirements
2. Build a Conceptual Model
3. Build a Logical Model
4. Build a Physical Model

## Conceptual Models
Conceptual models: represents the entities and their relationships.  
Visualization of entities and relationships: Entity Relationship(ER)/Unified Modelling Languages(UML).  
Modelling tools:
1. Microsoft Visio
2. [draw.io](https://app.diagrams.net/)
3. LucidCharts

draw.io example:  
<img width="475" alt="image" src="https://user-images.githubusercontent.com/60777462/171609743-8afe3c0d-c969-4e9e-b5ae-8a71418e4d46.png">

## Build a Logical Models
Realationships between entities:
1. One-to-one
2. One-to-many
3. Many-to-many

<img width="606" alt="image" src="https://user-images.githubusercontent.com/60777462/171612337-ff1db15d-5441-46e4-a2dd-2ffe3ee1d709.png">

## Physical Models
In MySQL Workbench, File -> New Model -> change Physical Schemas name to School -> Add diagram -> Add a new table -> Add columns
EER(enhence entity relationship) diagrams: can create entity reationship diagrams.

<img width="545" alt="image" src="https://user-images.githubusercontent.com/60777462/171615992-798bb240-cfdb-4908-9a0a-c78a5d212c60.png">

## Primary Keys
Primary Key: Identify each record uniquely.   
student_id and course_id are the primary key for student table and course table respectively.

<img width="560" alt="image" src="https://user-images.githubusercontent.com/60777462/171616922-e74da4d3-1705-44b5-8582-2e251dd60c0d.png">

## Foreign Keys
When ever a relationship is added between two tables, one end of the relationship is called parent/primary key table, another is called child/foreign key table.  
Use the 1:n relationship to link the enrollment table with student table and course table respectively.   
Use composite primary key for the enrollment table.

<img width="557" alt="image" src="https://user-images.githubusercontent.com/60777462/171659967-c6f1dc38-3ea6-41e2-bf1d-165b3963c762.png">

## Foreign Key Constraints
Set constraints on foreign keys to protect data from be destroyed.  
Some On update/ On delete options for foreign key(when primary key of a table changes)
1. CASCADE: MySQL will automatically update/delete according to primary key.
2. RESTRICT: reject update.
3. SET NULL
4. NO ACTION: Same as RESTRICT

## Normalization
Normalization: review design, follow predefined rules and prevent data duplication.  

## First Normal Form (1NF)
[First Normal Form (1NF)](https://en.wikipedia.org/wiki/First_normal_form): Each cell should has a single value and we cannot have repeated columns.  
In the example, tags in courses table does not follow the 1NF, a new table tags should be added.  

<img width="555" alt="image" src="https://user-images.githubusercontent.com/60777462/171666979-4fc05e7b-bb78-423e-9e39-ddaa8bf06fcd.png">

## Link Tables
In relational databases, there is no many-to-many link, so use link table and two one-to-many links to represent many-to-many relationship.

<img width="692" alt="image" src="https://user-images.githubusercontent.com/60777462/171667205-7718a257-c970-40b0-98d6-5a69720e03e3.png">

## Second Normal Form (2NF)
[Second normal form (2NF)](https://en.wikipedia.org/wiki/Second_normal_form): Every **table** should describe **one entity**, and every column in that table should describe that entity. 
A relation is in the second normal form if it fulfills the following two requirements:

1. It is in first normal form.
2. It does not have any non-prime attribute that is functionally dependent on any proper subset of any candidate key of the relation. A non-prime attribute of a relation is an attribute that is not a part of any candidate key of the relation.

A relation is in 2NF if it is in 1NF and every non-prime attribute of the relation is dependent on the whole of every candidate key. Note that it does not put any restriction on the non-prime to non-prime attribute dependency. That is addressed in third normal form.

In the example, since one instructor may teach several courses, it is not an attribute of course.

<img width="731" alt="image" src="https://user-images.githubusercontent.com/60777462/171787366-9c8b41b8-27fe-41f9-84c6-bf13f5daf645.png">

## Third Normal Form (3NF)
[Third Normal Form (3NF)](https://en.wikipedia.org/wiki/Third_normal_form): A column in a table should not be derived from other columns.  
For example, full_name column can be derived from the combination of first_name and last_name.  

## Pragmatic Advice
Start from logical or conceptual model, do not consider too much about normalization.   
Do not jump into creating tables!  

## Don't Model the Universe!

