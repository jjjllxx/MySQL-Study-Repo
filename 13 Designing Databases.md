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
