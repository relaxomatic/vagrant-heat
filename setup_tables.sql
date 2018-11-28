DROP SCHEMA IF EXISTS heat;
CREATE SCHEMA heat AUTHORIZATION heat;
GRANT ALL ON SCHEMA heat TO heat;

SET search_path TO heat;

DROP TABLE IF EXISTS combined;
CREATE TABLE combined
(
     "species" VARCHAR (100),
     "breed" VARCHAR(100),
     "masterproblem" VARCHAR(100),
     "datetime" BIGINT,
     "animal" VARCHAR(100),
     "geocode" POINT
);
ALTER TABLE combined
    OWNER to heat;