# Job_Applications_Tracker
This repository contains a complete SQL portfolio project that simulates a real-world job applications management system. The goal of this project is to demonstrate strong skills in relational database design, CRUD operations, data integrity, and analytical queries.

# 🗄️ Job Applications Management System (SQL Project)

## 📌 Overview
This project implements a **job applications management system** using SQL.  
It simulates the backend of a recruiting portal, with full **CRUD operations** and analytical queries.  

The goal is to demonstrate skills in:
- Relational schema design
- Constraints (PK, FK, UNIQUE, CHECK)
- CRUD operations
- Analytical queries for reporting
- Referential integrity management

---

## 🏗️ Project Structure
The project is organized into multiple SQL files:

- `create-table.sql` → database schema (`candidates`, `companies`, `jobs`, `applications`)
- `insert-data.sql` → sample dataset to populate the database
- `crud-operations.sql` → examples of **Create, Read, Update, Delete**
- `queries.sql` → analytical and reporting queries
- `README.md` → project documentation

---

## 📂 Database Schema
- **candidates** → job seekers (id, name, email, location, skills)  
- **companies** → companies (id, name, industry, location)  
- **jobs** → job offers (id, company_id, title, department, date_posted)  
- **applications** → job applications (id, candidate_id, job_id, status, date_applied, last_update)  

🔗 Main relationships:
- A candidate can have multiple applications  
- A company can post multiple jobs  
- Each application links one candidate ↔ one job  

---

## ⚙️ Main Features
### CRUD Examples
- **Candidates**
  - Create new candidate
  - Read candidate by ID
  - Search candidates by skill
  - Update candidate contact
  - Delete candidate
- **Companies**
  - Create company
  - Read companies
  - Update company details
  - Delete company
- **Jobs**
  - Create job for a company
  - List jobs by company
  - List jobs by date range
  - Update job details
  - Delete job
- **Applications**
  - Create application
  - Read applications for candidate
  - Advance application status
  - 
  - Bulk update stale applications (e.g., from `applied` → `in_review` if older than 30 days)

### Analytical Queries

- Pipeline by companies
- Pipeline by job
- Hire rate by companies
- Competitiveness by role
- Mean/median apply time → last_update
- Aging > N days
- Job without applications
- Super active candidates
- Most “popular” companies
- Cohort mensile (apply)
- FK sanity check
- Drop-off by status
- Maps by location
