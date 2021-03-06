--
-- File generated with SQLiteStudio v3.0.7 on Tue Jan 12 14:24:09 2016
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: os_instance
CREATE TABLE os_instance (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, hostname INTEGER REFERENCES hostname (id) NOT NULL UNIQUE, service_profile INTEGER REFERENCES service_profile (id) NOT NULL DEFAULT (0), ipv4_bond INTEGER REFERENCES ipv4_address (id) UNIQUE, is_provisioned INTEGER NOT NULL DEFAULT (0), is_verified INTEGER DEFAULT (0) NOT NULL, is_active INTEGER NOT NULL DEFAULT (0), is_in_maintenance INTEGER NOT NULL DEFAULT (0));

-- Table: service
CREATE TABLE service (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL);
INSERT INTO service (id, name) VALUES (1, 'Nginx');
INSERT INTO service (id, name) VALUES (2, 'MySQL');
INSERT INTO service (id, name) VALUES (3, 'Redis');
INSERT INTO service (id, name) VALUES (4, 'Application');

-- Table: hardware_type
CREATE TABLE hardware_type (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_manufacturer INTEGER NOT NULL REFERENCES hardware_manufacturer (id), name TEXT NOT NULL, info TEXT);

-- Table: hardware_manufacturer
CREATE TABLE hardware_manufacturer (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);
INSERT INTO hardware_manufacturer (id, name) VALUES (1, 'HP');
INSERT INTO hardware_manufacturer (id, name) VALUES (2, 'Dell');
INSERT INTO hardware_manufacturer (id, name) VALUES (3, 'Cisco');
INSERT INTO hardware_manufacturer (id, name) VALUES (4, 'Juniper');

-- Table: ipv4_address
CREATE TABLE ipv4_address (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);

-- Table: hostname
CREATE TABLE hostname (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);

-- Table: location
CREATE TABLE location (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, parent INTEGER REFERENCES location (id), name TEXT NOT NULL, latitude REAL, longitude REAL, info TEXT);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (1, NULL, 'North America', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (2, 1, 'United States', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (3, 2, 'California', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (4, 3, 'SJC01', NULL, NULL, 'Provider A');
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (5, 3, 'SJC02', NULL, NULL, 'Provider B');

-- Table: location_rack_type
CREATE TABLE location_rack_type (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL);
INSERT INTO location_rack_type (id, name) VALUES (1, 'Standard');
INSERT INTO location_rack_type (id, name) VALUES (2, 'Network');
INSERT INTO location_rack_type (id, name) VALUES (3, 'Special Cabling');

-- Table: hardware_instance
CREATE TABLE hardware_instance (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_type INTEGER REFERENCES hardware_type (id) NOT NULL, location_rack INTEGER REFERENCES location_rack (id) NOT NULL, rack_height INTEGER, ipv4_address_lom INTEGER REFERENCES ipv4_address (id) UNIQUE);

-- Table: service_profile
CREATE TABLE service_profile (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL);
INSERT INTO service_profile (id, name) VALUES (0, 'Unprovisioned Server');
INSERT INTO service_profile (id, name) VALUES (1, 'Application Server');
INSERT INTO service_profile (id, name) VALUES (2, 'Database Server');
INSERT INTO service_profile (id, name) VALUES (3, 'Web Cache Server');

-- Table: location_rack
CREATE TABLE location_rack (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, location_rack_type INTEGER NOT NULL REFERENCES location_rack_type (id), location INTEGER REFERENCES location (id) NOT NULL, name TEXT NOT NULL);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
