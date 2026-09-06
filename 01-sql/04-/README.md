# MySQL - Day 04: Database Keys

## What I Learned

Today I learned about different types of keys used in relational databases to uniquely identify records and maintain data integrity.

### Super Key

* A super key is one or more columns that can uniquely identify a row in a table.
* A super key can contain extra columns that are not necessary for uniquely identifying the row.
* Every candidate key is also a super key.

### Candidate Key

* A candidate key is a super key that can uniquely identify a record without unnecessary columns.
* A table can have multiple candidate keys.
* A candidate key must be unique and minimal.
* One candidate key can be selected as the primary key.

### Minimal Key

* A minimal key is a key that uniquely identifies a record and contains no unnecessary attributes.
* If removing any attribute causes the key to lose its uniqueness, the key is minimal.
* Candidate keys are minimal super keys.

### Natural Key

* A natural key is a key that comes from real-world or business data.
* Examples include email address, phone number, country code, or a business identification number.
* Natural keys have meaning outside the database.
* Natural keys can sometimes change when real-world information changes.

### Surrogate Key

* A surrogate key is an artificial key created specifically for identifying records.
* It has no real-world meaning.
* Common examples include auto-incrementing integer IDs.
* Surrogate keys are generally stable and do not depend on business data.

## Key Relationships

A useful way to understand the relationship between these keys is:

**Super Key → Minimal Super Key → Candidate Key**

A candidate key is a **minimal super key**.

A natural key and a surrogate key describe **where the key comes from**, while super key, candidate key, and minimal key describe **how the key uniquely identifies a record**.

## Practice

I solved 10 practical problems covering:

* Identifying super keys
* Identifying candidate keys
* Understanding minimal keys
* Finding natural keys
* Understanding natural key limitations
* Creating surrogate keys
* Comparing natural keys and surrogate keys
* Identifying different types of keys in real-world tables
* Choosing an appropriate primary key
* Applying key concepts to database design

## Key Learning

The main thing I learned today is that database keys are important for uniquely identifying records.

A **super key** can contain unnecessary columns, while a **candidate key** is a minimal super key.

A **natural key** has real-world meaning, while a **surrogate key** is an artificial identifier created by the database or application.

## Practice File

`practice.sql` contains all 10 problems and my solutions.

## Technology

* MySQL

---

**Day:** 04
**Topic:** Super Key, Candidate Key, Minimal Key, Natural Key & Surrogate Key
**Learning Journey:** Data Engineering
