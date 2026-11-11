MySQL - Day 05: Aggregate Functions, GROUP BY & HAVING

What I Learned

Today I continued learning MySQL and practiced filtering, calculations, grouping, and summarizing data using aggregate functions.

Filtering

- IN
- NOT IN
- AND
- OR
- Filtering records based on multiple conditions
- Combining IN with other conditions

Aliases

- Using AS to create column aliases
- Giving meaningful names to calculated results
- Improving the readability of query results

Aggregate Functions

- MIN() - Finds the minimum value
- MAX() - Finds the maximum value
- COUNT() - Counts records
- SUM() - Calculates the total value
- AVG() - Calculates the average value

GROUP BY

- Grouping rows based on one or more columns
- Using aggregate functions with GROUP BY
- Calculating statistics for each group
- Grouping employee data by department and role

HAVING

- Filtering grouped results
- Using HAVING with aggregate functions
- Understanding the difference between WHERE and HAVING

WHERE filters individual rows before grouping, while HAVING filters groups after GROUP BY.

## Practice

I solved 10 practical problems covering:

- Filtering data using `IN` and `NOT IN`
- Combining conditions using `AND` and `OR`
- Using column aliases
- Finding minimum and maximum values
- Counting records
- Calculating total values using `SUM()`
- Calculating averages using `AVG()`
- Grouping data using `GROUP BY`
- Filtering grouped results using `HAVING`
- Combining filtering, aggregation, grouping, and sorting in a real-world challenge

## Key Learning

Aggregate functions help summarize multiple rows into meaningful results.

`GROUP BY` allows data to be divided into groups so aggregate functions can be applied to each group.

`HAVING` is used to filter the results of grouped data based on aggregate conditions.

I also learned that `WHERE` is used to filter rows before grouping, while `HAVING` is used to filter groups after grouping.

## Practice File

`practice.sql` contains all 10 problems and my solutions.

## Technology

- MySQL

---

**Day:** 05  
**Topic:** Aggregate Functions, GROUP BY & HAVING  
**Learning Journey:** Data Engineering