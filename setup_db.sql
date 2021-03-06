DROP DATABASE IF EXISTS heat;
DROP TABLESPACE IF EXISTS heat;
DROP SCHEMA IF EXISTS heat;
DROP USER IF EXISTS heat;

CREATE USER heat WITH ENCRYPTED PASSWORD 'H3@tF33t';
ALTER USER heat SUPERUSER CREATEDB;
CREATE DATABASE heat WITH
    OWNER = heat
    ENCODING = 'UTF8'
    LC_COLLATE = 'C.UTF-8'
    LC_CTYPE = 'C.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
GRANT ALL PRIVILEGES ON DATABASE heat TO heat;
