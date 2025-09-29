/* Insert new candidate */
INSERT INTO candidates (name, email, location, skills) VALUES
('Antonio Gonzalez', 'antonio.gonzalez@gmail.com', 'Madrid', 'JavaScript, React ');

/* Read candidate by id */
SELECT * FROM candidates
WHERE candidate_id = 13;

/* Search candidates by skill */
SELECT * FROM candidates
WHERE skills LIKE '%Python%';

/* Update candidate contact */
UPDATE candidates SET
    email = 'elena.greco99@gmail.com', location = 'New York'
    WHERE candidate_id = 7;

/* Delete candidate */
DELETE FROM candidates
    WHERE candidate_id = 13;

/* Create company */
INSERT INTO companies (name, industry, location) VALUES
('Apple', 'Electronics', 'Cupertino');

/* Read companies */
SELECT * FROM companies
    ORDER BY company_id;

/* Update company location/industry */
UPDATE companies SET
    industry = 'IT', location = 'Firenze'
    WHERE name = 'TechWave';

/* Delete company */
DELETE FROM companies
    WHERE name = 'Apple';

/* Create job for a company */
INSERT INTO jobs (company_id, title, department, date_posted) VALUES
(10, 'Junior DEV', 'Developer', '2025-09-27');

/* List jobs by company */
SELECT * FROM jobs
    WHERE company_id = 1;

/* List jobs by date range */
SELECT job_id, title, department, date_posted FROM jobs
    WHERE date_posted BETWEEN '2020-01-01' AND '2020-12-31';

/* Update job details */
UPDATE jobs SET
    title = 'DevOps Trainee'
    WHERE job_id = 14;

/* Delete job */
DELETE FROM jobs
    WHERE job_id = 15;

/* Create application */
INSERT INTO applications (candidate_id, job_id, status, date_applied, last_update)VALUES
(1, 1, 'in_review', '2025-09-28', '2025-09-28');

/* Read applications for candidate */
SELECT * FROM applications
    WHERE candidate_id = 1;

/* Advance application status */
UPDATE applications SET
    status = 'interview', last_update = '2025-09-28'
    WHERE application_id = 4;

/* Bulk update stale applications */
UPDATE applications SET
    status = 'in_review',
    last_update = CURRENT_DATE
WHERE status = 'applied'
AND date_applied < (CURRENT_DATE - 30);
