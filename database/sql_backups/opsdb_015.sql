--
-- File generated with SQLiteStudio v3.0.7 on Mon Feb 1 10:37:12 2016
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: service
CREATE TABLE service (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO service (id, name) VALUES (1, 'Nginx');
INSERT INTO service (id, name) VALUES (2, 'MySQL');
INSERT INTO service (id, name) VALUES (3, 'Redis');
INSERT INTO service (id, name) VALUES (4, 'Application');

-- Table: hardware_type
CREATE TABLE hardware_type (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_manufacturer INTEGER NOT NULL REFERENCES hardware_manufacturer (id), name TEXT NOT NULL UNIQUE, info TEXT);
INSERT INTO hardware_type (id, hardware_manufacturer, name, info) VALUES (1, 1, 'ESXi 6.0', NULL);

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

-- Table: hostname
CREATE TABLE hostname (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);

-- Table: argument_type
CREATE TABLE argument_type (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, argument_type_base INTEGER REFERENCES argument_type (id), info TEXT);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (1, 'Integer', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (2, 'String', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (3, 'Real', NULL, NULL);
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (4, 'Schema Table', 1, 'Integer that references schema_table.id');
INSERT INTO argument_type (id, name, argument_type_base, info) VALUES (5, 'Schema Field', 1, 'Integer that references schema_table_field.id');

-- Table: version_commit
CREATE TABLE version_commit (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user_id INTEGER NOT NULL REFERENCES user (id), data_json TEXT);

-- Table: schema_table_field
CREATE TABLE schema_table_field (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, schema_table INTEGER REFERENCES schema_table (id) NOT NULL, name TEXT NOT NULL, argument_type INTEGER REFERENCES argument_type (id) NOT NULL, column_order INTEGER NOT NULL, is_primary_key INTEGER NOT NULL DEFAULT (0), allow_null INTEGER DEFAULT (0) NOT NULL, default_value TEXT, label_default TEXT);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (1, 1, 'name', 2, 0, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (2, 1, 'seq', 2, 1, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (3, 2, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (4, 2, 'parent', 1, 1, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (5, 2, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (6, 2, 'latitude', 3, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (7, 2, 'longitude', 3, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (8, 2, 'info', 2, 5, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (9, 3, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (10, 3, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (11, 4, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (12, 4, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (13, 5, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (14, 5, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (15, 6, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (16, 6, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (17, 7, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (18, 7, 'service_profile', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (19, 7, 'service', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (20, 8, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (21, 8, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (22, 9, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (23, 9, 'product', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (24, 9, 'service_profile', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (25, 10, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (26, 10, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (27, 10, 'ipv4_network', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (28, 11, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (29, 11, 'hostname', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (30, 11, 'service_profile', 1, 2, 0, 0, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (31, 11, 'ipv4_bond', 1, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (32, 11, 'is_provisioned', 1, 4, 0, 0, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (33, 11, 'is_verified', 1, 5, 0, 0, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (34, 11, 'is_active', 1, 6, 0, 0, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (35, 11, 'is_in_maintenance', 1, 7, 0, 0, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (36, 12, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (37, 12, 'ipv4_address', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (38, 12, 'os_instance', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (39, 12, 'os_instance_next', 1, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (40, 12, 'interface', 2, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (41, 13, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (42, 13, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (43, 13, 'ipv4_address_network', 1, 2, 0, 0, NULL, 'IPv4 Network');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (44, 13, 'ipv4_address_broadcast', 1, 3, 0, 0, NULL, 'IPv4 Broadcast');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (45, 14, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (46, 14, 'ipv4_address', 1, 1, 0, 0, NULL, 'IPv4 Address');
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (47, 14, 'os_instance', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (48, 14, 'os_instance_next', 1, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (49, 14, 'interface', 2, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (50, 15, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (51, 15, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (52, 16, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (53, 16, 'hardware_manufacturer', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (54, 16, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (55, 16, 'info', 2, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (56, 17, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (57, 17, 'location_rack_type', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (58, 17, 'location', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (59, 17, 'name', 2, 3, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (60, 17, 'name_alternate', 2, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (61, 18, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (62, 18, 'hardware_type', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (63, 18, 'parent', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (64, 18, 'location_rack', 1, 3, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (65, 18, 'rack_height', 1, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (66, 18, 'ipv4_address_lom', 1, 5, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (67, 19, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (68, 19, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (69, 20, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (70, 20, 'web_site', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (71, 20, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (72, 20, 'info', 2, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (73, 21, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (74, 21, 'web_site', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (75, 21, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (76, 22, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (77, 22, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (78, 22, 'path', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (79, 22, 'info', 2, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (80, 23, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (81, 23, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (82, 23, 'argument_type_base', 1, 2, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (83, 23, 'info', 2, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (84, 24, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (85, 24, 'argument_type', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (86, 24, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (87, 24, 'info', 2, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (88, 25, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (89, 25, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (90, 25, 'sqlite3_path', 2, 2, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (91, 25, 'mysql_hostname', 2, 3, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (92, 25, 'mysql_port', 1, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (93, 25, 'mysql_user', 2, 5, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (94, 25, 'mysql_password_path', 2, 6, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (95, 26, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (96, 26, 'schema', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (97, 26, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (98, 27, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (99, 27, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (100, 28, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (101, 28, 'web_site_map', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (102, 28, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (103, 28, 'priority', 1, 3, 0, 1, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (104, 28, 'parent', 1, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (105, 29, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (106, 29, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (107, 29, 'label', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (108, 29, 'is_read_only', 1, 3, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (109, 29, 'info', 2, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (110, 30, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (111, 30, 'schema_table', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (112, 30, 'name', 2, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (113, 30, 'argument_type', 1, 3, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (114, 30, 'column_order', 1, 4, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (115, 30, 'is_primary_key', 1, 5, 0, 0, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (116, 30, 'allow_null', 1, 6, 0, 0, '0', NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (117, 30, 'default_value', 2, 7, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (120, 27, 'web_site', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (121, 28, 'web_site_page', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (122, 32, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (123, 32, 'web_site_page', 1, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (124, 32, 'web_widget', 1, 2, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (125, 32, 'name', 2, 3, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (126, 32, 'info', 2, 4, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (127, 32, 'data_json', 2, 5, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (128, 33, 'id', 1, 0, 1, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (129, 33, 'name', 2, 1, 0, 0, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (130, 33, 'value', 2, 2, 0, 1, NULL, NULL);
INSERT INTO schema_table_field (id, schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value, label_default) VALUES (131, 33, 'sql', 2, 3, 0, 1, NULL, NULL);

-- Table: os_instance
CREATE TABLE os_instance (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, hostname INTEGER REFERENCES hostname (id) NOT NULL UNIQUE, service_profile INTEGER REFERENCES service_profile (id) NOT NULL DEFAULT (0), ipv4_bond INTEGER REFERENCES ipv4_address (id) UNIQUE, is_provisioned INTEGER NOT NULL DEFAULT (0), is_verified INTEGER DEFAULT (0) NOT NULL, is_active INTEGER NOT NULL DEFAULT (0), is_in_maintenance INTEGER NOT NULL DEFAULT (0));

-- Table: web_site_map_item
CREATE TABLE web_site_map_item (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site_map INTEGER REFERENCES web_site (id) NOT NULL, web_site_page INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL, priority INTEGER DEFAULT (0) NOT NULL, parent INTEGER REFERENCES web_site_map_item (id), icon TEXT);
INSERT INTO web_site_map_item (id, web_site_map, web_site_page, name, priority, parent, icon) VALUES (1, 1, 1, 'Dashboard', 100, NULL, 'heart');
INSERT INTO web_site_map_item (id, web_site_map, web_site_page, name, priority, parent, icon) VALUES (2, 1, 1, 'Another Page', 0, NULL, 'apple');
INSERT INTO web_site_map_item (id, web_site_map, web_site_page, name, priority, parent, icon) VALUES (3, 1, 1, 'Folder Example', 0, NULL, 'sun-o');
INSERT INTO web_site_map_item (id, web_site_map, web_site_page, name, priority, parent, icon) VALUES (4, 1, 1, 'Child Page A', 0, 3, 'reply');
INSERT INTO web_site_map_item (id, web_site_map, web_site_page, name, priority, parent, icon) VALUES (5, 1, 1, 'Child Page B', 10, 3, 'upload');

-- Table: product
CREATE TABLE product (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, version TEXT, UNIQUE (name, version));
INSERT INTO product (id, name, version) VALUES (1, 'Frobulator', '1.7');
INSERT INTO product (id, name, version) VALUES (2, 'Frobulator', '2.1');
INSERT INTO product (id, name, version) VALUES (3, 'Internal Zombulancer', '0.1');
INSERT INTO product (id, name, version) VALUES (4, 'OpsDB', '26.0.0');

-- Table: web_site_map
CREATE TABLE web_site_map (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL);
INSERT INTO web_site_map (id, web_site, name) VALUES (1, 1, 'Main');

-- Table: schema
CREATE TABLE schema (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT UNIQUE NOT NULL, sqlite3_path TEXT UNIQUE, mysql_hostname TEXT, mysql_port INTEGER, mysql_user TEXT, mysql_password_path TEXT);
INSERT INTO schema (id, name, sqlite3_path, mysql_hostname, mysql_port, mysql_user, mysql_password_path) VALUES (1, 'opsdb', 'database/opsdb.db', NULL, NULL, NULL, NULL);

-- Table: web_widget
CREATE TABLE web_widget (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, path TEXT NOT NULL UNIQUE, info TEXT);
INSERT INTO web_widget (id, name, path, info) VALUES (1, 'Dashboard Stat', 'scripts/webui/html_content/dashboard_stat_icon.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (2, 'Data Table', 'scripts/webui/html_content/data_table.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (3, 'Stat List', 'scripts/webui/html_content/stat_list.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (4, 'Area Chart - Simple', 'scripts/webui/html_content/area_chart.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (5, 'Donut Chart', 'scripts/webui/html_content/donut_chart.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (6, 'Bar Chart', 'scripts/webui/html_content/bar_chart.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (7, 'Chat', 'scripts/webui/html_content/chat.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (8, 'Timeline', 'scripts/webui/html_content/timeline.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (9, 'Dropdown: Messages', 'scripts/webui/html_content/dropdown_messages.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (10, 'Dropdown: Tasks', 'scripts/webui/html_content/dropdown_tasks.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (11, 'Dropdown: Stats', 'scripts/webui/html_content/dropdown_stats.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (12, 'Navbar Side', 'scripts/webui/html_content/navbar_side.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (13, 'Dialog - Modal', 'scripts/webui/html_content/dialog_modal.html', NULL);
INSERT INTO web_widget (id, name, path, info) VALUES (14, 'JSON Data Result', 'scripts/webui/html_content/json_data_result.html', NULL);

-- Table: ipv4_address_loadbalancer
CREATE TABLE ipv4_address_loadbalancer (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ipv4_address INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, os_instance INTEGER REFERENCES os_instance (id) NOT NULL, os_instance_next INTEGER REFERENCES os_instance (id), interface TEXT);

-- Table: service_profile_service
CREATE TABLE service_profile_service (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, service_profile INTEGER REFERENCES service_profile (id) NOT NULL, service INTEGER REFERENCES service (id) NOT NULL);

-- Table: hardware_instance
CREATE TABLE hardware_instance (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, hardware_type INTEGER REFERENCES hardware_manufacturer (id) NOT NULL, parent INTEGER REFERENCES hardware_instance (id) NOT NULL, location_rack INTEGER REFERENCES location_rack (id) NOT NULL, rack_height INTEGER, ipv4_address_lom INTEGER REFERENCES ipv4_address (id) UNIQUE);

-- Table: hardware_manufacturer
CREATE TABLE hardware_manufacturer (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
INSERT INTO hardware_manufacturer (id, name) VALUES (1, 'VMWare');
INSERT INTO hardware_manufacturer (id, name) VALUES (2, 'HP');
INSERT INTO hardware_manufacturer (id, name) VALUES (3, 'Dell');
INSERT INTO hardware_manufacturer (id, name) VALUES (4, 'Cisco');
INSERT INTO hardware_manufacturer (id, name) VALUES (5, 'Juniper');

-- Table: service_profile
CREATE TABLE service_profile (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO service_profile (id, name) VALUES (0, 'Unprovisioned Server');
INSERT INTO service_profile (id, name) VALUES (1, 'Application Server');
INSERT INTO service_profile (id, name) VALUES (2, 'Database Server');
INSERT INTO service_profile (id, name) VALUES (3, 'Web Cache Server');

-- Table: stats
CREATE TABLE stats (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, value TEXT, icon TEXT, color TEXT, sql TEXT);
INSERT INTO stats (id, name, value, icon, color, sql) VALUES (1, 'Services', '4', 'gears', 'primary', 'SELECT COUNT(*) AS value FROM service');
INSERT INTO stats (id, name, value, icon, color, sql) VALUES (2, 'Products', '4', 'archive', 'info', 'SELECT COUNT(*) AS value FROM product');
INSERT INTO stats (id, name, value, icon, color, sql) VALUES (3, 'Hardware', '0', 'tasks', 'danger', 'SELECT COUNT(*) AS value FROM hardware_instance');
INSERT INTO stats (id, name, value, icon, color, sql) VALUES (4, 'OSes', '0', 'cube', 'warning', 'SELECT COUNT(*) AS value FROM os_instance');

-- Table: version_working
CREATE TABLE version_working (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user_id INTEGER NOT NULL REFERENCES user (id), data_json TEXT);

-- Table: web_site_page_widget
CREATE TABLE web_site_page_widget (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site_page INTEGER REFERENCES web_site_page (id) NOT NULL, web_widget INTEGER REFERENCES web_widget (id) NOT NULL, name TEXT NOT NULL UNIQUE, priority INTEGER NOT NULL DEFAULT (0), info TEXT, data_json TEXT);
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (1, 1, 1, 'stats_services', 0, 'Stats: Services', '{"name":"Services", "value":"__table.stats.1.value", "view":"5", "color":"primary"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (2, 1, 1, 'stats_tables', 0, 'Stats: Schema Tables', '{"name":"Products", "value":"__table.stats.2.value", "view":"8", "color":"green"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (3, 1, 1, 'stats_os', 0, 'Stats: OSes', '{"name":"OSes", "value":"__table.stats.4.value", "view":"11", "color":"red"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (4, 1, 1, 'stats_hw', 0, 'Stats: Hardware', '{"name":"Hardware", "value":"__table.stats.3.value", "view":"18", "color":"yellow"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (5, 1, 2, 'table_service', 0, 'Table: Services', '{"rows":"__rows.service", "fields":"__fields.service", "title":"Services"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (6, 1, 2, 'table_os', 0, 'Table: OSes', '{"rows":"__rows.os_instance", "fields":"__fields.os_instance", "title":"OSes"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (7, 1, 3, 'stat_list', 0, 'Stats: List', '{"items":"__rows.stats", "button_label":"View All Stats", "title":"Stats"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (8, 1, 4, 'chart_area_stats', 0, 'Chart: Stats', '{"items":"__rows.stats", "title":"Chart of Stats"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (9, 1, 5, 'chart_donut_stats', 0, 'Chart: Stats', '{"items":"__rows.stats", "button_label":"View All Stats", "title":"Stats"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (10, 1, 6, 'chart_bar_stats', 0, 'Chart: Stats', '{"items":"__rows.stats", "button_label":"View All Stats", "title":"Stats"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (11, 1, 7, 'chat_stats', 0, 'Chat', '{"items":"__rows.stats", "button_label":"Send", "title":"Chat about Stats"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (12, 1, 8, 'timeline_stats', 0, 'Timeline: Stats', '{"items":"__rows.stats", "title":"Timeline of Stats"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (13, 1, 9, 'dropdown_messages', 0, 'Messages', '{"items":"__rows.stats", "button_label":"View All Messages", "icon":"envelope-o"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (14, 1, 10, 'dropdown_tasks', 0, 'Tasks', '{"items":"__rows.stats", "button_label":"View All Tasks", "icon":"key"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (15, 1, 11, 'dropdown_comments', 0, 'Comments', '{"items":"__rows.stats", "button_label":"View All Stats", "icon":"film"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (16, 1, 12, 'navbar_side', 0, 'Navbar Side', '{"items":"__rows.web_site_map_item"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (17, 2, 13, 'dialog', 5, 'RPC: Dialog: Table List', '{"body":"__page_widget.table_list", "buttons":"", "title":"Generic Table Dialog"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (18, 2, 2, 'table_list', 10, 'Table List', '{"rows":"__rows.{table}", "fields":"__fields.{table}", "title":"Generic Table List"}');
INSERT INTO web_site_page_widget (id, web_site_page, web_widget, name, priority, info, data_json) VALUES (19, 2, 14, 'data_json', 0, 'RPC: JSON Data Result', '{"data_json":"__json_data.{dialog}"}');

-- Table: web_site_domain
CREATE TABLE web_site_domain (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL UNIQUE);
INSERT INTO web_site_domain (id, web_site, name) VALUES (1, 1, 'localhost');
INSERT INTO web_site_domain (id, web_site, name) VALUES (2, 1, 'opsdb.internal.yourdomain.com');

-- Table: ipv4_network
CREATE TABLE ipv4_network (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, ipv4_address_network INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, ipv4_address_broadcast INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE);

-- Table: version_changelist
CREATE TABLE version_changelist (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, user_id INTEGER NOT NULL REFERENCES user (id), data_json TEXT);

-- Table: ipv4_address_floating
CREATE TABLE ipv4_address_floating (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, ipv4_address INTEGER REFERENCES ipv4_address (id) NOT NULL UNIQUE, os_instance INTEGER REFERENCES os_instance (id) NOT NULL, os_instance_next INTEGER REFERENCES os_instance (id), interface TEXT);

-- Table: web_site
CREATE TABLE web_site (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, default_web_site_map INTEGER, path_prefix TEXT);
INSERT INTO web_site (id, name, default_web_site_map, path_prefix) VALUES (1, 'OpsDB', 1, NULL);

-- Table: location
CREATE TABLE location (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, parent INTEGER REFERENCES location (id), name TEXT NOT NULL, latitude REAL, longitude REAL, info TEXT);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (1, NULL, 'North America', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (2, 1, 'United States', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (3, 2, 'California', NULL, NULL, NULL);
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (4, 3, 'SJC01', NULL, NULL, 'Provider A');
INSERT INTO location (id, parent, name, latitude, longitude, info) VALUES (5, 3, 'SJC02', NULL, NULL, 'Provider B');

-- Table: location_rack_type
CREATE TABLE location_rack_type (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL UNIQUE);
INSERT INTO location_rack_type (id, name) VALUES (1, 'Standard');
INSERT INTO location_rack_type (id, name) VALUES (2, 'Network');
INSERT INTO location_rack_type (id, name) VALUES (3, 'Special Cabling');

-- Table: location_rack
CREATE TABLE location_rack (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, location_rack_type INTEGER NOT NULL REFERENCES location_rack_type (id), location INTEGER REFERENCES location (id) NOT NULL, name TEXT NOT NULL UNIQUE, name_alternate TEXT);

-- Table: user
CREATE TABLE user (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, password_digest TEXT);

-- Table: ipv4_address
CREATE TABLE ipv4_address (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, ipv4_network INTEGER REFERENCES "sqlitestudio_temp_table0" (id) NOT NULL);

-- Table: web_widget_argument
CREATE TABLE web_widget_argument (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL UNIQUE, argument_type INTEGER NOT NULL REFERENCES argument_type (id), info TEXT);
INSERT INTO web_widget_argument (id, name, argument_type, info) VALUES (1, 'name', 2, 'Title');
INSERT INTO web_widget_argument (id, name, argument_type, info) VALUES (2, 'value', 1, 'Integer Value of Counter');
INSERT INTO web_widget_argument (id, name, argument_type, info) VALUES (3, 'view', 4, 'View Detail for a Schema Table in Dialog box');

-- Table: product_service_profile
CREATE TABLE product_service_profile (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, product INTEGER REFERENCES product (id) NOT NULL, service_profile INTEGER REFERENCES service_profile (id) NOT NULL);

-- Table: web_site_page
CREATE TABLE web_site_page (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, web_site INTEGER REFERENCES web_site (id) NOT NULL, name TEXT NOT NULL UNIQUE, path TEXT, title TEXT, info TEXT);
INSERT INTO web_site_page (id, web_site, name, path, title, info) VALUES (1, 1, 'index.html', 'index.html', 'SLiCUIST Demo', 'Index');
INSERT INTO web_site_page (id, web_site, name, path, title, info) VALUES (2, 1, 'rpc/dialog_table_list', 'rpc_base.html', 'RPC: Dialog: Table List', 'List all rows in a table');

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

-- Table: argument_type_validation
CREATE TABLE argument_type_validation (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, argument_type INTEGER REFERENCES argument_type (id) NOT NULL, name TEXT NOT NULL UNIQUE, label TEXT UNIQUE NOT NULL, info TEXT);
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (1, 1, 'Percentage', 'percent', 'Values: 0 to 100');
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (2, 3, 'Normalized Value', 'normalized', 'Value: 0.0 to 1.0');
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (3, 2, 'Email Address', 'email', 'Example: name@domain.com');
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (4, 2, 'URL', 'url', 'Example: http://www.google.com/');
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (5, 2, 'Domain Name', 'domain', 'Example: www.google.com');
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (6, 2, 'IPv4 Address', 'ipv4', 'Example: 10.0.0.1');
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (7, 2, 'IPv6 Address', 'ipv6', 'Example: ...');
INSERT INTO argument_type_validation (id, argument_type, name, label, info) VALUES (8, 2, 'Phone Number', 'phone', 'Example: 650-555-1212');

-- Index: unique_rack_height
CREATE UNIQUE INDEX unique_rack_height ON hardware_instance (location_rack, rack_height);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
