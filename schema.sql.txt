DROP TABLE IF EXISTS gis_projects;

CREATE TABLE gis_projects (
    id          SERIAL PRIMARY KEY,
    name        TEXT NOT NULL,
    city        TEXT NOT NULL,
    country     TEXT NOT NULL,
    technology  TEXT NOT NULL,
    start_date  DATE NOT NULL,
    status      TEXT NOT NULL
);

ALTER TABLE gis_projects
    ADD CONSTRAINT status_check
    CHECK (status IN ('planned', 'ongoing', 'completed'));
