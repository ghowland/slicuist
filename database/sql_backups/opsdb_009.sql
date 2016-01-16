--
-- File generated with SQLiteStudio v3.0.7 on Sat Jan 16 01:46:50 2016
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: hardware_type
CREATE TABLE hardware_type (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_manufacturer INTEGER NOT NULL REFERENCES hardware_manufacturer (id), name TEXT NOT NULL UNIQUE, info TEXT);
INSERT INTO hardware_type (id, hardware_manufacturer, name, info) VALUES (1, 1, 'ESXi 6.0', NULL);

-- Table: hostname
CREATE TABLE hostname (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);

-- Table: service_profile
CREATE TABLE service_profile (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO service_profile (id, name) VALUES (0, 'Unprovisioned Server');
INSERT INTO service_profile (id, name) VALUES (1, 'Application Server');
INSERT INTO service_profile (id, name) VALUES (2, 'Database Server');
INSERT INTO service_profile (id, name) VALUES (3, 'Web Cache Server');

-- Table: service
CREATE TABLE service (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO service (id, name) VALUES (1, 'Nginx');
INSERT INTO service (id, name) VALUES (2, 'MySQL');
INSERT INTO service (id, name) VALUES (3, 'Redis');
INSERT INTO service (id, name) VALUES (4, 'Application');

-- Table: hardware_instance
CREATE TABLE hardware_instance (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_type INTEGER REFERENCES hardware_manufacturer (id) NOT NULL, parent INTEGER REFERENCES hardware_instance (id) NOT NULL, location_rack INTEGER REFERENCES location_rack (id) NOT NULL, rack_height INTEGER, ipv4_address_lom INTEGER REFERENCES ipv4_address (id) UNIQUE);

-- Table: schema_table_field
CREATE TABLE schema_table_field (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, schema_table INTEGER REFERENCES schema_table (id) NOT NULL, name TEXT NOT NULL, argument_type INTEGER REFERENCES argument_type (id) NOT NULL, column_order INTEGER NOT NULL, is_primary_key INTEGER NOT NULL DEFAULT (0), allow_null INTEGER DEFAULT (0) NOT NULL, default_value TEXT);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (1, 1, 'name', 2, 0, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (2, 1, 'seq', 2, 1, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (3, 2, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (4, 2, 'parent', 1, 1, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (5, 2, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (6, 2, 'latitude', 3, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (7, 2, 'longitude', 3, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (8, 2, 'info', 2, 5, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (9, 3, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (10, 3, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (11, 4, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (12, 4, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (13, 5, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (14, 5, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (15, 6, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (16, 6, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (17, 7, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (18, 7, 'service_profile', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (19, 7, 'service', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (20, 8, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (21, 8, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (22, 9, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (23, 9, 'product', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (24, 9, 'service_profile', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (25, 10, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (26, 10, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (27, 10, 'ipv4_network', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (28, 11, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (29, 11, 'hostname', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (30, 11, 'service_profile', 1, 2, 0, 0, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (31, 11, 'ipv4_bond', 1, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (32, 11, 'is_provisioned', 1, 4, 0, 0, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (33, 11, 'is_verified', 1, 5, 0, 0, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (34, 11, 'is_active', 1, 6, 0, 0, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (35, 11, 'is_in_maintenance', 1, 7, 0, 0, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (36, 12, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (37, 12, 'ipv4_address', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (38, 12, 'os_instance', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (39, 12, 'os_instance_next', 1, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (40, 12, 'interface', 2, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (41, 13, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (42, 13, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (43, 13, 'ipv4_address_network', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (44, 13, 'ipv4_address_broadcast', 1, 3, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (45, 14, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (46, 14, 'ipv4_address', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (47, 14, 'os_instance', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (48, 14, 'os_instance_next', 1, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (49, 14, 'interface', 2, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (50, 15, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (51, 15, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (52, 16, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (53, 16, 'hardware_manufacturer', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (54, 16, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (55, 16, 'info', 2, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (56, 17, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (57, 17, 'location_rack_type', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (58, 17, 'location', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (59, 17, 'name', 2, 3, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (60, 17, 'name_alternate', 2, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (61, 18, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (62, 18, 'hardware_type', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (63, 18, 'parent', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (64, 18, 'location_rack', 1, 3, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (65, 18, 'rack_height', 1, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (66, 18, 'ipv4_address_lom', 1, 5, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (67, 19, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (68, 19, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (69, 20, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (70, 20, 'web_site', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (71, 20, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (72, 20, 'info', 2, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (73, 21, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (74, 21, 'web_site', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (75, 21, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (76, 22, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (77, 22, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (78, 22, 'path', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (79, 22, 'info', 2, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (80, 23, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (81, 23, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (82, 23, 'argument_type_base', 1, 2, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (83, 23, 'info', 2, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (84, 24, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (85, 24, 'argument_type', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (86, 24, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (87, 24, 'info', 2, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (88, 25, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (89, 25, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (90, 25, 'sqlite3_path', 2, 2, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (91, 25, 'mysql_hostname', 2, 3, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (92, 25, 'mysql_port', 1, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (93, 25, 'mysql_user', 2, 5, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (94, 25, 'mysql_password_path', 2, 6, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (95, 26, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (96, 26, 'schema', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (97, 26, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (98, 27, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (99, 27, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (100, 28, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (101, 28, 'web_site_map', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (102, 28, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (103, 28, 'priority', 1, 3, 0, 1, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (104, 28, 'parent', 1, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (105, 29, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (106, 29, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (107, 29, 'label', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (108, 29, 'is_read_only', 1, 3, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (109, 29, 'info', 2, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (110, 30, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (111, 30, 'schema_table', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (112, 30, 'name', 2, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (113, 30, 'argument_type', 1, 3, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (114, 30, 'column_order', 1, 4, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (115, 30, 'is_primary_key', 1, 5, 0, 0, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (116, 30, 'allow_null', 1, 6, 0, 0, '0');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (117, 30, 'default_value', 2, 7, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (120, 27, 'web_site', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (121, 28, 'web_site_page', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (122, 32, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (123, 32, 'web_site_page', 1, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (124, 32, 'web_widget', 1, 2, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (125, 32, 'name', 2, 3, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (126, 32, 'info', 2, 4, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (127, 32, 'data_json', 2, 5, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (128, 33, 'id', 1, 0, 1, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (129, 33, 'name', 2, 1, 0, 0, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (130, 33, 'value', 2, 2, 0, 1, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (131, 33, 'sql', 2, 3, 0, 1, NULL);

-- Table: argument_type
CREATE TABLE argument_type (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, argument_type_base INTEGER REFERENCES argument_type (id), info TEXT);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (1, 'Integer', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (2, 'String', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (3, 'Real', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (4, 'Schema Table', 1, 'Integer that references schema_table.id');
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (5, 'Schema Field', 1, 'Integer that references schema_table_field.id');

-- Table: os_instance
CREATE TABLE os_instance (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, hostname INTEGER REFERENCES hostname (id) NOT NULL UNIQUE, service_profile INTEGER REFERENCES service_profile (id) NOT NULL DEFAULT (0), ipv4_bond INTEGER REFERENCES ipv4_address (id) UNIQUE, is_provisioned INTEGER NOT NULL DEFAULT (0), is_verified INTEGER DEFAULT (0) NOT NULL, is_active INTEGER NOT NULL DEFAULT (0), is_in_maintenance INTEGER NOT NULL DEFAULT (0));

-- Table: web_widget
CREATE TABLE web_widget (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, path TEXT NOT NULL UNIQUE, info TEXT);
INSERT INTO web_widget (id, name, path, info) VALUES (1, 'Dashboard Stat', 'scripts/webui/html_content/dashboard_stat_icon.html', NULL);

-- Table: schema
CREATE TABLE schema (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT UNIQUE NOT NULL, sqlite3_path TEXT UNIQUE, mysql_hostname TEXT, mysql_port INTEGER, mysql_user TEXT, mysql_password_path TEXT);
INSERT INTO schema (id, name, sqlite3_path, mysql_hostname, mysql_port, mysql_user, mysql_password_path) VALUES (1, 'opsdb', 'database/opsdb.db', NULL, NULL, NULL, NULL);

-- Table: service_profile_service
CREATE TABLE service_profile_service (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, service_profile INTEGER REFERENCES service_profile (id) NOT NULL, service INTEGER REFERENCES service (id) NOT NULL);

-- Table: web_site_map
CREATE TABLE web_site_map (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL);
INSERT INTO web_site_map (id, web_site, name) VALUES (1, 1, 'Main');

-- Table: web_site_map_item
CREATE TABLE web_site_map_item (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site_map INTEGER REFERENCES web_site_map (id) NOT NULL, web_site_page INTEGER REFERENCES web_site_page (id) NOT NULL, name TEXT NOT NULL, priority INTEGER DEFAULT (0), parent INTEGER REFERENCES web_site_map_item (id));
INSERT INTO web_site_map_item (id, web_site_map, web_site_page, name, priority, parent) VALUES (1, 1, 1, 'Dashboard', 100, NULL);

-- Table: ipv4_address_loadbalancer
CREATE TABLE ipv4_address_loadbalancer (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ipv4_address INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, os_instance INTEGER REFERENCES os_instance (id) NOT NULL, os_instance_next INTEGER REFERENCES os_instance (id), interface TEXT);

-- Table: product
CREATE TABLE product (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);

-- Table: logic_operation
CREATE TABLE logic_operation (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, label TEXT UNIQUE NOT NULL, is_read_only INTEGER NOT NULL, info TEXT);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (1, '=', 'Assignment', 0, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (2, '==', 'Equivalent', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (3, '===', 'Same', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (4, '<', 'Less Than', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (5, '>', 'Greater Than', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (6, '<=', 'Less Than or Equal', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (7, '>=', 'Greater Than or Equal', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (8, '!=', 'Not Equal', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (9, 'in', 'In Set', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (10, 'not in', 'Not In Set', 1, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (11, '+=', 'Increment', 0, NULL);
INSERT INTO logic_operation (id, name, label, is_read_only, info) VALUES (12, '-=', 'Decrement', 0, '');

-- Table: ipv4_address_floating
CREATE TABLE ipv4_address_floating (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ipv4_address INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, os_instance INTEGER REFERENCES os_instance (id) NOT NULL, os_instance_next INTEGER REFERENCES os_instance (id), interface TEXT);

-- Table: web_site_page_widget
CREATE TABLE web_site_page_widget (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site_page INTEGER REFERENCES web_site_page (id) NOT NULL, web_widget INTEGER REFERENCES web_widget (id) NOT NULL, name TEXT NOT NULL UNIQUE, info TEXT, data_json TEXT);
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, info, data_json) VALUES (1, 1, 1, 'Stats Thing', NULL, '{"name":"Services", "value":"table.stats.1", "view":"table.5"}');

-- Table: location
CREATE TABLE location (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, parent INTEGER REFERENCES location (id), name TEXT NOT NULL, latitude REAL, longitude REAL, info TEXT);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (1, NULL, 'North America', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (2, 1, 'United States', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (3, 2, 'California', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (4, 3, 'SJC01', NULL, NULL, 'Provider A');
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (5, 3, 'SJC02', NULL, NULL, 'Provider B');

-- Table: web_site_domain
CREATE TABLE web_site_domain (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO web_site_domain (id, web_site, name) VALUES (1, 1, 'localhost');
INSERT INTO web_site_domain (id, web_site, name) VALUES (2, 1, 'opsdb.internal.yourdomain.com');

-- Table: ipv4_network
CREATE TABLE ipv4_network (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, ipv4_address_network INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, ipv4_address_broadcast INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE);

-- Table: web_site
CREATE TABLE web_site (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO web_site (id, name) VALUES (1, 'OpsDB');

-- Table: hardware_manufacturer
CREATE TABLE hardware_manufacturer (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
INSERT INTO hardware_manufacturer (id, name) VALUES (1, 'VMWare');
INSERT INTO hardware_manufacturer (id, name) VALUES (2, 'HP');
INSERT INTO hardware_manufacturer (id, name) VALUES (3, 'Dell');
INSERT INTO hardware_manufacturer (id, name) VALUES (4, 'Cisco');
INSERT INTO hardware_manufacturer (id, name) VALUES (5, 'Juniper');

-- Table: stats
CREATE TABLE stats (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, value TEXT, sql TEXT);
INSERT INTO stats (id, name, value, sql) VALUES (1, 'Services', '4', 'SELECT COUNT(*) AS value FROM service');
INSERT INTO stats (id, name, value, sql) VALUES (2, 'Schema Tables', '32', 'SELECT COUNT(*) AS value FROM schema_table');
INSERT INTO stats (id, name, value, sql) VALUES (3, 'Hardware', '0', 'SELECT COUNT(*) AS value FROM hardware_instance');
INSERT INTO stats (id, name, value, sql) VALUES (4, 'OSes', '0', 'SELECT COUNT(*) AS value FROM os_instance');

-- Table: location_rack
CREATE TABLE location_rack (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, location_rack_type INTEGER NOT NULL REFERENCES location_rack_type (id), location INTEGER REFERENCES location (id) NOT NULL, name TEXT NOT NULL UNIQUE, name_alternate TEXT);

-- Table: web_widget_argument
CREATE TABLE web_widget_argument (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, argument_type INTEGER NOT NULL REFERENCES argument_type (id), info TEXT);
INSERT INTO web_widget_argument (id, name, argument_type, info) VALUES (1, 'name', 2, 'Title');
INSERT INTO web_widget_argument (id, name, argument_type, info) VALUES (2, 'value', 1, 'Integer Value of Counter');
INSERT INTO web_widget_argument (id, name, argument_type, info) VALUES (3, 'view', 4, 'View Detail for a Schema Table in Dialog box');

-- Table: location_rack_type
CREATE TABLE location_rack_type (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
INSERT INTO location_rack_type (id, name) VALUES (1, 'Standard');
INSERT INTO location_rack_type (id, name) VALUES (2, 'Network');
INSERT INTO location_rack_type (id, name) VALUES (3, 'Special Cabling');

-- Table: ipv4_address
CREATE TABLE ipv4_address (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, ipv4_network INTEGER REFERENCES "sqlitestudio_temp_table0" (id) NOT NULL);

-- Table: web_site_page
CREATE TABLE web_site_page (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL UNIQUE, info TEXT);
INSERT INTO web_site_page (id, web_site, name, info) VALUES (1, 1, 'index.html', 'Index');

-- Table: product_service_profile
CREATE TABLE product_service_profile (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, product INTEGER REFERENCES product (id) NOT NULL, service_profile INTEGER REFERENCES service_profile (id) NOT NULL);

-- Table: schema_table
CREATE TABLE schema_table (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, schema INTEGER REFERENCES schema (id) NOT NULL, name TEXT UNIQUE NOT NULL);
INSERT INTO schema_table (id, schema, name) VALUES (1, 1, 'sqlite_sequence');
INSERT INTO schema_table (id, schema, name) VALUES (2, 1, 'location');
INSERT INTO schema_table (id, schema, name) VALUES (3, 1, 'hostname');
INSERT INTO schema_table (id, schema, name) VALUES (4, 1, 'location_rack_type');
INSERT INTO schema_table (id, schema, name) VALUES (5, 1, 'service');
INSERT INTO schema_table (id, schema, name) VALUES (6, 1, 'service_profile');
INSERT INTO schema_table (id, schema, name) VALUES (7, 1, 'service_profile_service');
INSERT INTO schema_table (id, schema, name) VALUES (8, 1, 'product');
INSERT INTO schema_table (id, schema, name) VALUES (9, 1, 'product_service_profile');
INSERT INTO schema_table (id, schema, name) VALUES (10, 1, 'ipv4_address');
INSERT INTO schema_table (id, schema, name) VALUES (11, 1, 'os_instance');
INSERT INTO schema_table (id, schema, name) VALUES (12, 1, 'ipv4_address_loadbalancer');
INSERT INTO schema_table (id, schema, name) VALUES (13, 1, 'ipv4_network');
INSERT INTO schema_table (id, schema, name) VALUES (14, 1, 'ipv4_address_floating');
INSERT INTO schema_table (id, schema, name) VALUES (15, 1, 'hardware_manufacturer');
INSERT INTO schema_table (id, schema, name) VALUES (16, 1, 'hardware_type');
INSERT INTO schema_table (id, schema, name) VALUES (17, 1, 'location_rack');
INSERT INTO schema_table (id, schema, name) VALUES (18, 1, 'hardware_instance');
INSERT INTO schema_table (id, schema, name) VALUES (19, 1, 'web_site');
INSERT INTO schema_table (id, schema, name) VALUES (20, 1, 'web_site_page');
INSERT INTO schema_table (id, schema, name) VALUES (21, 1, 'web_site_domain');
INSERT INTO schema_table (id, schema, name) VALUES (22, 1, 'web_widget');
INSERT INTO schema_table (id, schema, name) VALUES (23, 1, 'argument_type');
INSERT INTO schema_table (id, schema, name) VALUES (24, 1, 'web_widget_argument');
INSERT INTO schema_table (id, schema, name) VALUES (25, 1, 'schema');
INSERT INTO schema_table (id, schema, name) VALUES (26, 1, 'schema_table');
INSERT INTO schema_table (id, schema, name) VALUES (27, 1, 'web_site_map');
INSERT INTO schema_table (id, schema, name) VALUES (28, 1, 'web_site_map_item');
INSERT INTO schema_table (id, schema, name) VALUES (29, 1, 'logic_operation');
INSERT INTO schema_table (id, schema, name) VALUES (30, 1, 'schema_table_field');
INSERT INTO schema_table (id, schema, name) VALUES (32, 1, 'web_site_page_widget');
INSERT INTO schema_table (id, schema, name) VALUES (33, 1, 'stats');

-- Index: unique_rack_height
CREATE UNIQUE INDEX unique_rack_height ON hardware_instance (location_rack, rack_height);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
