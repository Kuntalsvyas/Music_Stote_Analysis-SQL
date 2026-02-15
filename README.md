# 🎵 Music Store Data Analysis (SQL)

---

## 📌 Project Overview
This project involves a comprehensive analysis of a digital music store's database using **PostgreSQL**. The goal is to extract actionable insights regarding customer behavior, sales performance, and artist popularity to help the business grow and optimize its operations.

I have categorized the SQL challenges into three levels: **Basic**, **Moderate**, and **Advance**, demonstrating proficiency in everything from simple data retrieval to complex subqueries and Window Functions.

---

## 🗃️ Database Schema
The analysis is performed on a relational database consisting of 11 tables including:
* **Employee & Customer:** Tracking staff hierarchy and customer demographics.
* **Invoice & InvoiceLine:** Sales transactions and itemized billing.
* **Track, Album, & Artist:** The core music catalog details.
* **Genre & Media Type:** Categorization of music assets.

---

## 🚀 Key Questions Answered

### 🟢 Level 1: Basic (Foundational Retrieval)
* Senior-most employee based on job title.
* Countries with the highest number of invoices.
* Identifying the top 3 values of total invoices.
* Best city for a promotional Music Festival (Highest revenue).
* Identifying the "Best Customer" (The one who spent the most money).
---
### 🟡 Level 2: Moderate (Joins & Logic)
* Returning the Email, First Name, and Last Name of all **Rock Music** listeners.
* Identifying the top 10 artists who have written the most rock music tracks.
* Finding tracks that have a length longer than the average song duration.
---
### 🔴 Level 3: Advance (CTE & Window Functions)
* **Customer Spend on Artists:** Calculating how much each customer spent on specific artists.
* **Popular Genres by Country:** Determining the most popular music genre for each country based on the number of purchases.
* **Top Spender by Country:** Using **CTEs** and **Recursive Queries** to find the customer that has spent the most on music for each country.

---

## 🛠️ Technical Skills Demonstrated
* **Joins:** `INNER JOIN`, `LEFT JOIN` across multiple tables (e.g., joining 5 tables to get artist sales).
* **Aggregations:** `SUM`, `COUNT`, `AVG`, `GROUP BY`, `HAVING`.
* **Advanced Filtering:** `LIKE`, `IN`, `Subqueries`.
* **Window Functions:** `ROW_NUMBER()`, `RANK()` for ranking customers and genres.
* **Common Table Expressions (CTEs):** To simplify complex multi-step calculations.

---

## 📂 Repository Structure
| Folder | Description |
| :--- | :--- |
| 🟢 `Basic/` | Simple SQL queries for initial data exploration. |
| 🟡 `Moderate/` | Intermediate queries involving multiple joins and filtering. |
| 🔴 `Advance/` | Complex business logic using CTEs and Window Functions. |
| 📊 `MusicDatabaseSchema.png` | Visual representation of the ER Diagram. |
| 💾 `Music_Store_database.sql` | The script to set up the database and insert data. |

---

## 📈 How to Run
1. Install **PostgreSQL** or any SQL editor (pgAdmin, MySQL Workbench).
2. Run the `Music_Store_database.sql` script to create the tables and populate them.
3. Open the `.sql` files in the levels folders to view the solutions.

---

# 🙌 Author
Built by Kuntal Vyas If you found this useful, ⭐ the repo and share!

**Status** :- Learning/Practice Project
