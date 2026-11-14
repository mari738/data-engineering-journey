# MySQL - Day 06: NULL Handling & CASE WHEN

## What I Learned

Today I continued learning MySQL and practiced handling missing values and applying conditional logic using `CASE WHEN`.

### NULL Handling

- Understanding what `NULL` represents in a database
- Difference between `NULL` and `0`
- Difference between `NULL` and an empty string
- Checking NULL values using `IS NULL`
- Checking non-NULL values using `IS NOT NULL`
- Understanding why `= NULL` cannot be used to check NULL values
- Handling NULL values using `COALESCE()`
- Replacing NULL values with a default value
- Understanding how aggregate functions handle NULL values

### COALESCE

- `COALESCE()` returns the first non-NULL value
- Using `COALESCE()` to replace missing numeric values
- Using `COALESCE()` in calculations
- Preventing NULL values from causing NULL results in calculations

### CASE WHEN

- Using `CASE WHEN` for conditional logic
- Creating categories based on column values
- Using multiple `WHEN` conditions
- Using `ELSE` as a default result
- Using `CASE WHEN` with NULL conditions
- Combining `CASE WHEN` with `AND` and other conditions
- Using `CASE WHEN` with aggregate functions
- Understanding that `CASE` evaluates conditions from top to bottom and returns the first matching result

## Practice

I solved 10 practical problems covering:

- Finding NULL and non-NULL values
- Understanding NULL comparison
- Replacing NULL values using `COALESCE()`
- Performing calculations with NULL values
- Creating salary categories using `CASE WHEN`
- Creating bonus status categories
- Creating employee-level classifications
- Handling multiple conditions with `CASE WHEN`
- Combining NULL handling with conditional logic
- Using aggregate functions with NULL values
- Using `CASE WHEN` with `GROUP BY`
- Building a complete employee report using NULL handling and conditional logic

## Key Learning

`NULL` represents a missing or unknown value. It is not the same as `0` or an empty string.

`IS NULL` and `IS NOT NULL` are used to check for NULL values.

`COALESCE()` can be used to replace NULL with another value, which is especially useful when performing calculations.

`CASE WHEN` is used to apply conditional logic in SQL. It checks conditions from top to bottom and returns the result of the first condition that is true.

## Practice File

`practice.sql` contains all 10 problems and my solutions.

## Technology

- MySQL

---

**Day:** 06  
**Topic:** NULL Handling & CASE WHEN  
**Learning Journey:** Data Engineering