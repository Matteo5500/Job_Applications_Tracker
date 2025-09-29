CREATE TABLE IF NOT EXISTS  candidates(
    candidate_id SERIAL PRIMARY KEY NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    location TEXT NOT NULL,
    skills TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS companies(
    company_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    industry TEXT NOT NULL,
    location TEXT NOT NULL
);


CREATE TABLE IF NOT EXISTS jobs(
    job_id SERIAL PRIMARY KEY NOT NULL,
    company_id INTEGER NOT NULL REFERENCES companies(company_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    title TEXT NOT NULL,
    department TEXT,
    date_posted DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS applications(
    application_id SERIAL PRIMARY KEY,
    candidate_id INTEGER NOT NULL REFERENCES candidates(candidate_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    job_id INTEGER NOT NULL REFERENCES jobs(job_id) ON DELETE RESTRICT ON UPDATE CASCADE,
    status TEXT NOT NULL CHECK (status IN ('applied', 'in_review', 'interview', 'offer', 'rejected', 'hired')),
    date_applied DATE NOT NULL,
    last_update DATE NOT NULL,
    UNIQUE (candidate_id, job_id)
);
