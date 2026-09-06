# MySQL - Day 03: DELETE CASCADE, Soft Delete & DEFAULT

## What I Learned

Today I continued learning MySQL and practiced different ways of handling deletion and default values in database tables.

### DELETE CASCADE

* `ON DELETE CASCADE`
* How foreign keys work with cascading deletes
* Automatically deleting related child records when a parent record is deleted
* Understanding the relationship between parent and child tables
* Testing cascading deletes

### Soft Delete

* What is soft delete
* Using a flag such as `is_deleted` to mark records as deleted
* Difference between soft delete and permanent delete
* Retrieving active records
* Retrieving deleted records
* Restoring soft-deleted records

### DEFAULT

* `DEFAULT` constraint
* Automatically assigning a value when no value is provided
* Using default values for status fields
* Using default values for numeric fields
* Using `CURRENT_TIMESTAMP` for date/time values
* Overriding a default value when required

## Practice

I solved 10 practical problems covering:

* Creating columns with DEFAULT values
* Testing DEFAULT values
* Overriding DEFAULT values
* Creating parent and child tables
* Using foreign keys with `ON DELETE CASCADE`
* Testing cascading deletes
* Understanding the impact of deleting parent records
* Implementing soft delete
* Filtering active and deleted records
* Restoring soft-deleted records
* Combining DEFAULT, soft delete and DELETE CASCADE in a real-world scenario

## Key Learning

`ON DELETE CASCADE` automatically deletes related child records when the referenced parent record is deleted.

Soft delete does not permanently remove a record. Instead, a column such as `is_deleted` is updated to indicate that the record is no longer active.

The `DEFAULT` constraint automatically provides a value when a value is not specified during insertion.

### Hard Delete vs Soft Delete

**Hard Delete:**
The record is permanently removed from the table.

**Soft Delete:**
The record remains in the database but is marked as deleted, allowing it to be restored later if needed.

## Practice File

`practice.sql` contains all 10 problems and my solutions.

## Technology

* MySQL

---

**Day:** 03
**Topic:** DELETE CASCADE, Soft Delete & DEFAULT
**Learning Journey:** Data Engineering
