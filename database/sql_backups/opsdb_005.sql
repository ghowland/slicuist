--
-- File generated with SQLiteStudio v3.0.7 on Fri Jan 15 15:00:59 2016
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: hardware_type
CREATE TABLE hardware_type (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_manufacturer INTEGER NOT NULL REFERENCES hardware_manufacturer (id), name TEXT NOT NULL UNIQUE, info TEXT);
INSERT INTO hardware_type (id, hardware_manufacturer, name, info) VALUES (1, 1, 'ESXi 6.0', NULL);

-- Table: hardware_manufacturer
CREATE TABLE hardware_manufacturer (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
INSERT INTO hardware_manufacturer (id, name) VALUES (1, 'VMWare');
INSERT INTO hardware_manufacturer (id, name) VALUES (2, 'HP');
INSERT INTO hardware_manufacturer (id, name) VALUES (3, 'Dell');
INSERT INTO hardware_manufacturer (id, name) VALUES (4, 'Cisco');
INSERT INTO hardware_manufacturer (id, name) VALUES (5, 'Juniper');

-- Table: hostname
CREATE TABLE hostname (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);

-- Table: argument_type
CREATE TABLE argument_type (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, argument_type_base INTEGER REFERENCES argument_type (id), info TEXT);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (1, 'Integer', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (2, 'String', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (3, 'Real', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (4, 'Schema Table', 1, 'Integer that references schema_table.id');
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (5, 'Schema Field', 1, 'Integer that references schema_table_field.id');

-- Table: service
CREATE TABLE service (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO service (id, name) VALUES (1, 'Nginx');
INSERT INTO service (id, name) VALUES (2, 'MySQL');
INSERT INTO service (id, name) VALUES (3, 'Redis');
INSERT INTO service (id, name) VALUES (4, 'Application');

-- Table: os_instance
CREATE TABLE os_instance (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, hostname INTEGER REFERENCES hostname (id) NOT NULL UNIQUE, service_profile INTEGER REFERENCES service_profile (id) NOT NULL DEFAULT (0), ipv4_bond INTEGER REFERENCES ipv4_address (id) UNIQUE, is_provisioned INTEGER NOT NULL DEFAULT (0), is_verified INTEGER DEFAULT (0) NOT NULL, is_active INTEGER NOT NULL DEFAULT (0), is_in_maintenance INTEGER NOT NULL DEFAULT (0));

-- Table: ipv4_address_loadbalancer
CREATE TABLE ipv4_address_loadbalancer (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ipv4_address INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, os_instance INTEGER REFERENCES os_instance (id) NOT NULL, os_instance_next INTEGER REFERENCES os_instance (id), interface TEXT);

-- Table: hardware_instance
CREATE TABLE hardware_instance (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_type INTEGER REFERENCES hardware_manufacturer (id) NOT NULL, parent INTEGER REFERENCES hardware_instance (id) NOT NULL, location_rack INTEGER REFERENCES location_rack (id) NOT NULL, rack_height INTEGER, ipv4_address_lom INTEGER REFERENCES ipv4_address (id) UNIQUE);

-- Table: web_widget
CREATE TABLE web_widget (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, path TEXT NOT NULL UNIQUE, info TEXT);

-- Table: schema
CREATE TABLE schema (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT UNIQUE NOT NULL, sqlite3_path TEXT UNIQUE, mysql_hostname TEXT, mysql_port INTEGER, mysql_user TEXT, mysql_password_path TEXT);
INSERT INTO schema (id, name, sqlite3_path, mysql_hostname, mysql_port, mysql_user, mysql_password_path) VALUES (1, 'opsdb', 'database/opsdb.db', NULL, NULL, NULL, NULL);

-- Table: service_profile_service
CREATE TABLE service_profile_service (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, service_profile INTEGER REFERENCES service_profile (id) NOT NULL, service INTEGER REFERENCES service (id) NOT NULL);

-- Table: product
CREATE TABLE product (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);

-- Table: schema_table_field
CREATE TABLE schema_table_field (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, schema_table INTEGER REFERENCES schema (id) NOT NULL, name TEXT UNIQUE NOT NULL);

-- Table: ipv4_network
CREATE TABLE ipv4_network (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, ipv4_address_network INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, ipv4_address_broadcast INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE);

-- Table: product_service_profile
CREATE TABLE product_service_profile (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, product INTEGER REFERENCES product (id) NOT NULL, service_profile INTEGER REFERENCES service_profile (id) NOT NULL);

-- Table: web_site_domain
CREATE TABLE web_site_domain (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO web_site_domain (id, web_site, name) VALUES (1, 1, 'localhost');
INSERT INTO web_site_domain (id, web_site, name) VALUES (2, 1, 'opsdb.internal.yourdomain.com');

-- Table: ipv4_address_floating
CREATE TABLE ipv4_address_floating (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ipv4_address INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, os_instance INTEGER REFERENCES os_instance (id) NOT NULL, os_instance_next INTEGER REFERENCES os_instance (id), interface TEXT);

-- Table: location
CREATE TABLE location (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, parent INTEGER REFERENCES location (id), name TEXT NOT NULL, latitude REAL, longitude REAL, info TEXT);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (1, NULL, 'North America', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (2, 1, 'United States', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (3, 2, 'California', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (4, 3, 'SJC01', NULL, NULL, 'Provider A');
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (5, 3, 'SJC02', NULL, NULL, 'Provider B');

-- Table: web_site
CREATE TABLE web_site (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO web_site (id, name) VALUES (1, 'OpsDB');

-- Table: schema_table
CREATE TABLE schema_table (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, schema INTEGER REFERENCES schema (id) NOT NULL, name TEXT UNIQUE NOT NULL);

-- Table: service_profile
CREATE TABLE service_profile (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO service_profile (id, name) VALUES (0, 'Unprovisioned Server');
INSERT INTO service_profile (id, name) VALUES (1, 'Application Server');
INSERT INTO service_profile (id, name) VALUES (2, 'Database Server');
INSERT INTO service_profile (id, name) VALUES (3, 'Web Cache Server');

-- Table: location_rack_type
CREATE TABLE location_rack_type (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
INSERT INTO location_rack_type (id, name) VALUES (1, 'Standard');
INSERT INTO location_rack_type (id, name) VALUES (2, 'Network');
INSERT INTO location_rack_type (id, name) VALUES (3, 'Special Cabling');

-- Table: ipv4_address
CREATE TABLE ipv4_address (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, ipv4_network INTEGER REFERENCES "sqlitestudio_temp_table0" (id) NOT NULL);

-- Table: web_site_page
CREATE TABLE web_site_page (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL UNIQUE, info TEXT);

-- Table: web_widget_argument
CREATE TABLE web_widget_argument (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, argument_type INTEGER NOT NULL REFERENCES argument_type (id), name TEXT NOT NULL UNIQUE, info TEXT);

-- Table: location_rack
CREATE TABLE location_rack (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, location_rack_type INTEGER NOT NULL REFERENCES location_rack_type (id), location INTEGER REFERENCES location (id) NOT NULL, name TEXT NOT NULL UNIQUE, name_alternate TEXT);

-- Index: unique_rack_height
CREATE UNIQUE INDEX unique_rack_height ON hardware_instance (location_rack, rack_height);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
