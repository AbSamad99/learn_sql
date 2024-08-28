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

## CASE

In SQL, `CASE` is a conditional expression that allows you to perform different actions based on different conditions, similar to `IF-THEN-ELSE` logic in programming languages. The `CASE` statement evaluates a series of conditions and returns a result when the first condition is met. If no conditions are met, an optional `ELSE` part can provide a default result.

There are 2 kinds of `CASE` expressions

#### Simple CASE expression:

The simple CASE expression compares an expression to a set of simple expressions to determine the result.

```sql
SELECT job_id,
       job_title,
       CASE job_schedule_type
           WHEN 'FT' THEN 'Full-Time'
           WHEN 'PT' THEN 'Part-Time'
           WHEN 'CT' THEN 'Contract'
           ELSE 'Unknown'
       END AS schedule_description
FROM job_postings_fact;
```

#### Searched CASE expression:

The searched CASE expression evaluates a set of Boolean expressions to determine the result. It is a lot more powerfull as compared to the former.

```sql
SELECT job_id,
       job_title,
       salary,
       CASE
           WHEN salary > 100000 THEN 'High'
           WHEN salary BETWEEN 50000 AND 100000 THEN 'Medium'
           WHEN salary < 50000 THEN 'Low'
           ELSE 'No Salary Information'
       END AS salary_range
FROM job_postings_fact;
```

Subqueries and Common Table Expressions (CTEs) are both SQL constructs used to perform complex queries by breaking them down into simpler, more manageable parts. However, they have different syntax, use cases, and benefits. Here is a detailed comparison:

#### Subqueries

A subquery (also known as an inner query or nested query) is a query within another SQL query. The subquery is executed first, and its result is used by the outer query. Subqueries can be placed in different parts of an SQL statement, such as the `SELECT` list, `FROM` clause, `WHERE` clause, or `HAVING` clause.

**Types of Subqueries**:

1. **Scalar Subquery**: Returns a single value (one row, one column).
2. **Column Subquery**: Returns a single column with multiple rows.
3. **Row Subquery**: Returns a single row with multiple columns.
4. **Table Subquery**: Returns a full table (multiple rows and columns).

**Example**:

```sql
SELECT employee_id, first_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

#### Common Table Expressions (CTEs)

A Common Table Expression (CTE) is a temporary result set that you can reference within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE` statement. CTEs are defined using the `WITH` clause and can be thought of as named subqueries. CTEs are more readable and easier to manage, especially for complex queries.

**Example**:

```sql
WITH avg_salaries AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.employee_id, e.first_name, e.salary, a.avg_salary
FROM employees e
JOIN avg_salaries a ON e.department_id = a.department_id
WHERE e.salary > a.avg_salary;
```

#### Key Differences Between Subqueries and CTEs

| Feature         | Subquery                                               | Common Table Expression (CTE)                                                                     |
| --------------- | ------------------------------------------------------ | ------------------------------------------------------------------------------------------------- |
| **Definition**  | A query within another query.                          | A temporary result set that can be referenced within a `SELECT`, `INSERT`, `UPDATE`, or `DELETE`. |
| **Syntax**      | Placed directly in the `SELECT`, `FROM`, `WHERE`, etc. | Defined using the `WITH` keyword.                                                                 |
| **Readability** | Can be less readable, especially when nested.          | More readable, allows for better organization of code.                                            |
| **Reuse**       | Subqueries are not reusable within the same query.     | CTEs can be referenced multiple times within the same query.                                      |
| **Recursion**   | Not suitable for recursion.                            | Can be used for recursive queries.                                                                |
| **Performance** | May lead to repeated calculations in some cases.       | Often optimized by the database engine, more efficient for complex queries.                       |
| **Scope**       | Limited to the statement in which they are used.       | Can be defined once and used in multiple places in the query.                                     |
