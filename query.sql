SELECT status, COUNT(*) AS count FROM applications
GROUP BY status;

/* Pipeline by companies */
SELECT status, name, COUNT(*) FROM applications
JOIN jobs ON jobs.job_id = applications.job_id
 JOIN companies ON companies.company_id = jobs.company_id
 GROUP BY applications.status, companies.name;

/* Pipeline by job */
SELECT status, title, COUNT(*) FROM applications
JOIN jobs ON jobs.job_id = applications.job_id
GROUP BY applications.status, jobs.title;

/* Hire rate by companies */
SELECT
  companies.name AS company_name,
  COUNT(*) AS total_apps,
  SUM(CASE WHEN applications.status = 'hired' THEN 1 ELSE 0 END) AS hires,
  ROUND(SUM(CASE WHEN applications.status = 'hired' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS hire_rate_pct
FROM applications
JOIN jobs ON applications.job_id = jobs.job_id
JOIN companies ON jobs.company_id = companies.company_id
GROUP BY companies.name;

/* Competitiveness by role */
SELECT 
  jobs.title AS job_title,
  companies.name AS company_name,
  COUNT(*) AS applications
FROM applications
JOIN jobs ON applications.job_id = jobs.job_id
JOIN companies ON jobs.company_id = companies.company_id
GROUP BY jobs.title, companies.name
ORDER BY applications DESC;

/* Mean/median apply time → last_update */
SELECT 
  AVG((last_update - date_applied)) AS avg_days,
  PERCENTILE_CONT(0.5) WITHIN GROUP (
    ORDER BY (last_update - date_applied)
  ) AS median_days
FROM applications;

/* Aging > N giorni */
SELECT * FROM applications
WHERE last_update < (CURRENT_DATE - 15);
AND status = 'in review';

/* Job without applications */
SELECT * FROM jobs
JOIN applications ON applications.job_id = jobs.job_id
WHERE NOT EXISTS(
  SELECT 1 FROM applications
  WHERE applications.job_id = jobs.job_id);

/* Super active candidates */
SELECT candidates.name, candidates.candidate_id, COUNT(applications.candidate_id) AS conta_app FROM candidates
JOIN applications ON applications.candidate_id = candidates.candidate_id
GROUP BY candidates.candidate_id
ORDER BY conta_app, candidates.candidate_id DESC
LIMIT 5;

/* Most “popular” companies */
SELECT companies.name, companies.company_id, COUNT(applications.application_id) AS conta_biz FROM companies
JOIN jobs ON companies.company_id = jobs.company_id
JOIN applications ON applications.job_id = jobs.job_id
GROUP BY companies.company_id
ORDER BY conta_biz DESC
LIMIT 3;

/* Cohort mensile (apply) */
SELECT 
  TO_CHAR(date_applied, 'YYYY-MM') AS month,
  COUNT(*) AS apps,
  SUM(CASE WHEN status = 'interview' THEN 1 ELSE 0 END) AS interviews,
  SUM(CASE WHEN status = 'offer' THEN 1 ELSE 0 END) AS offers,
  SUM(CASE WHEN status = 'hired' THEN 1 ELSE 0 END) AS hires
FROM applications
GROUP BY TO_CHAR(date_applied, 'YYYY-MM')
ORDER BY month ASC;

/* FK sanity check */
SELECT * FROM applications
LEFT JOIN candidates ON applications.candidate_id = candidates.candidate_id
LEFT JOIN jobs ON applications.job_id = jobs.job_id 
WHERE applications.application_id IS NULL
OR jobs.job_id IS NULL;

/* Drop-off by status */
WITH total AS (
  SELECT COUNT(*) AS total_apps FROM applications
)
SELECT 
  status,
  COUNT(*) AS count,
  ROUND(100.0 * COUNT(*) / total.total_apps, 2) AS pct_cumulative
FROM applications, total
GROUP BY status, total.total_apps
ORDER BY 
  CASE status
    WHEN 'applied' THEN 1
    WHEN 'in_review' THEN 2
    WHEN 'interview' THEN 3
    WHEN 'offer' THEN 4
    WHEN 'hired' THEN 5
    ELSE 99
  END;

/* Maps by location */
SELECT 
  candidates.location AS candidate_location,
  companies.location AS company_location,
  COUNT(*) AS apps_count
FROM applications
JOIN candidates ON applications.candidate_id = candidates.candidate_id
JOIN jobs ON applications.job_id = jobs.job_id
JOIN companies ON jobs.company_id = companies.company_id
GROUP BY candidates.location, companies.location
ORDER BY apps_count DESC;
