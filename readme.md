# SQL Notes

## DB where you can practice:

1. [Invoicing DB](https://lukeb.co/sql_invoices_db)
2. [Jobs DB](https://lukeb.co/sql_jobs_db)

## Order of actual execution

Understanding the logical order of SQL query execution helps write more efficient queries, optimize performance, and ensure correct results. While SQL is written in a readable order for humans, the database engine optimizes and processes it in a logical order that makes sense for data retrieval and manipulation.

1. From/Join - Specify the table(s) to retrieve the data
2. Where - Filter **rows** based on some condition
3. Group by - Specify the column to group by for aggregation functions
4. Having - Filters based on aggregate conditions (aggregations functions cannot be used in Where clause)
5. Select - Specify the colums to display the result
6. Distinct (applied after Select)
7. Order by - Sort by colums in asc or desc manner
8. Limit - Limit the number of rows that are returned.

## Order of writing the query

The way an SQL query is written and the way it is executed internally by the database are different.

1. Select
2. From
3. Where
4. Group by
5. Having
6. Order by
7. Limit

## Types of Join

1. Left Join - One of the most common type of join. It returns all the rows of the left table, along with the matched rows of the right table.
2. Right Join - Not as common. It returns all the rows of the right table, along with the matched rows of the left table.
3. Inner Join - Another common type of join and the default in most SQL variants. It only returns the common matched rows from either table.
4. Full Outer Join - Basically returns all the rows from both the tables.

# Union vs Join

| Feature              | **JOIN**                                                       | **UNION**                                                                 |
| -------------------- | -------------------------------------------------------------- | ------------------------------------------------------------------------- |
| **Purpose**          | Combines columns from two or more tables based on a condition. | Combines the result sets of two or more SELECT queries.                   |
| **Data Combination** | Horizontal (adds more columns).                                | Vertical (adds more rows).                                                |
| **Condition**        | Requires a join condition (`ON` clause).                       | No condition needed; SELECT queries must have the same number of columns. |
| **Duplicates**       | May produce duplicates based on data.                          | Removes duplicates by default; use `UNION ALL` to keep all.               |
| **Output Structure** | Includes columns from all joined tables.                       | Same columns as in the SELECT queries.                                    |
| **Use Case**         | Merge related data from multiple tables.                       | Append results from multiple queries.                                     |

## Common Datatypes

1. `INT` - Whole number which is of 4 bytes.
2. `NUMERIC(precision,scale)` - Allows decimal values. Precision defines the total number of digits (including decimals!!) and scale defines the number of digits after the decimal point. Eg `123.456` with `NUMERIC(6,3)`.
3. `TEXT` - Unlimited length string.
4. `VARCHAR(n)` - Fixed length string where `n` defines the limit.
5. `BOOLEAN` - True/False.
6. `DATE` - Just the date.
7. `TIMESTAMP` - Date and time without timezone.
8. `TIMESTAMP WITH TIME ZONE` - Date and time with timezone.

## Table Manipulation

1. Create table - Create the table.
2. Insert into - add rows (data) to your table.
3. Alter table - Add, Rename, Alter (change datatype), and Drop columns.
4. Drop table - Delete the table.

Refer the [following](./sql_files/table_manipulation_basics.sql) for a better idea.
