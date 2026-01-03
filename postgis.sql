-- Enable PostGIS extension
CREATE EXTENSION IF NOT EXISTS postgis;

-- Add geometry column for project location
ALTER TABLE gis_projects
ADD COLUMN IF NOT EXISTS location geometry(Point, 4326);

-- Set coordinates for each city (WGS84)
UPDATE gis_projects
SET location = CASE city
    WHEN 'Baku' THEN ST_SetSRID(ST_MakePoint(49.8671, 40.4093), 4326)
    WHEN 'Ganja' THEN ST_SetSRID(ST_MakePoint(46.3606, 40.6828), 4326)
    WHEN 'Tbilisi' THEN ST_SetSRID(ST_MakePoint(44.7930, 41.7151), 4326)
    WHEN 'Istanbul' THEN ST_SetSRID(ST_MakePoint(28.9784, 41.0082), 4326)
    ELSE NULL
END;

-- Create spatial index on location (performance boost)
CREATE INDEX IF NOT EXISTS idx_gis_projects_location
ON gis_projects
USING GIST (location);

-- Example spatial query:
-- Distance of each project to Baku (meters)
SELECT
    name,
    city,
    ST_DistanceSphere(
        location,
        ST_SetSRID(ST_MakePoint(49.8671, 40.4093), 4326)
    ) AS distance_meters
FROM gis_projects
WHERE location IS NOT NULL
ORDER BY distance_meters;

-- Example spatial query:
-- Projects within 200 km of Baku
SELECT
    name,
    city
FROM gis_projects
WHERE location IS NOT NULL
  AND ST_DWithin(
        location,
        ST_SetSRID(ST_MakePoint(49.8671, 40.4093), 4326),
        200000  -- 200 km
      );
