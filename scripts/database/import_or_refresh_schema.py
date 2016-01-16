#!/usr/bin/python
"""
Import or Refresh the Database into the schema* tables inside the database.

This allows all tables and fields in the database to be accessed specifically
by a primary key reference, which will allow us more programmatic control
than if we use hard coded names or labels.

NOTE(g): This must be run from the Project's root directory, such as:
  
  $ ./code/database/import_or_refresh_schema.py

NOTE(g): This is a simple implementation made to deal with a SQLite3 database
and is not meant to be a production-class software design or implementation.
"""


import sys
import sqlite3

# We need to import from our CWD, which is lower than our module
sys.path.append('.')

# Database wrapper
from scripts import database
Query = database.Query


# This is the database we will get all our other databases from, if there is more than 1
SQLITE3_DATABASE_PATH = 'database/opsdb.db'   # CWD = ./code/database/

  
def GetDatabaseList(cursor):
  """Get all the databases we need to import."""
  databases = Query(cursor, "SELECT * FROM schema")
  
  return databases


def ImportOrRefreshAllDatabases(primary_cursor):
  """Import or Refresh the schema for all our databases
  
  Args:
    primary_cursor: Cursor object, our primary database which holds the schema data of all databases.  May be inspecting itself as well (probably)
  """
  # Get all our databases
  databases = GetDatabaseList(primary_cursor)
  
  # Loop over each database (database is a dict, from the "schema" table rows)
  for schema in databases:
    # Get the cursor for this specific database
    #NOTE(g): SQLite3 implementation only, for demo purposes, not production code
    cursor = database.GetDatabaseCursor(schema['sqlite3_path'])
    
    ImportOrRefreshSingleDatabase(primary_cursor, schema, cursor)




def ImportOrRefreshSingleDatabase(primary_cursor, schema, cursor):
  """Import in a single database, adds new tables and fields, deletes ones that arent in the live DB.  Basic sync."""
  sql = 'SELECT name FROM sqlite_master WHERE type = "table"'
  table_rows = database.Query(cursor, sql)
  actual_tables = {d['name']: d for d in table_rows}
  
  # Get all the tables
  existing_tables_list = Query(cursor, "SELECT * FROM schema_table WHERE schema = ?", [schema['id']])
  
  # Convert to dictionary keyed on the table name
  existing_tables = {d['name']: d for d in existing_tables_list}
  
  
  # Loop over each table
  for table in table_rows:
    # If the table isnt in the primary schema, add it
    if table['name'] not in existing_tables:
      print 'Adding table to schema: %s.%s' % (schema['name'], table['name'])
      
      sql = "INSERT INTO schema_table (schema, name) VALUES (%s, '%s')" % (schema['id'], table['name'])
      result = Query(cursor, sql)
      print 'SQL: %s' % sql
      print 'Result: %s' % result
    
    # Get the table data, now that we know it exists
    schema_table = Query(cursor, "SELECT * FROM schema_table WHERE name = ?", [table['name']])[0]
    
    # Get all the fields
    sql = "PRAGMA table_info(%s)" % schema_table['name']
    table_fields = Query(cursor, sql)
    actual_fields = {d['name']: d for d in table_fields}
    
    # Get all the existing fields
    existing_fields_list = Query(cursor, "SELECT * FROM schema_table_field WHERE schema_table = ?", [schema_table['id']])
    existing_fields = {d['name']: d for d in existing_fields_list}
    
    # Loop over all the fields
    for table_field in table_fields:
      # If this field isnt in the schema_table_field table, add it
      if table_field['name'] not in existing_fields:
        print 'Adding field:  %s.%s.%s' % (schema['name'], table['name'], table_field['name'])
        
        # Set the argument_type, which is the field data type, but using our generic argument_type table so we can share it with function arguments
        if table_field['type'] == 'INTEGER':
          argument_type = 1
        elif table_field['type'] == 'TEXT':
          argument_type = 2
        elif table_field['type'] == 'REAL':
          argument_type = 3
        else:
          argument_type = 2 # Default is String/TEXT
        
        # Allow NULL is the opposite of what SQLite3 tracks, but I think Allow NULL makes more sense, so doing it my way.  MySQL and Oracle track this way too.
        if table_field['notnull'] == 1:
          allow_null = 0
        else:
          allow_null = 1
        
        if table_field['dflt_value'] == None:
          default_value = 'NULL'
        else:
          default_value = "'%s'" % table_field['dflt_value']
        
        sql = "INSERT INTO schema_table_field (schema_table, name, argument_type, column_order, is_primary_key, allow_null, default_value) VALUES (%s, '%s', %s, %s, %s, %s, %s)"
        sql = sql % (schema_table['id'], table_field['name'], argument_type, table_field['cid'], table_field['pk'], allow_null, default_value)
        print 'Add Field: %s' % sql
        Query(cursor, sql)
      
      # Else, if this field is in the schema_table_field, but changed attributes, update them
      pass
    
    # Loop over existing fields and see if any have been deleted from the actual schema
    for table_field in existing_fields_list:
      if table_field['name'] not in actual_fields:
        print 'TODO(g): Delete field:  %s.%s.%s' % (schema['name'], table['name'], table_field['name'])
        
        sql = "DELETE FROM schema_table_field WHERE id = %s" % table_field['id']
        print 'Delete field: %s' % sql
        Query(cursor, sql)
  
  
  # Look for any existing tables that doesnt exist anymore, and delete them
  for (table_name, table) in existing_tables.items():
    if table['name'] not in actual_tables:
      print 'Deleting table: %s.%s' % (schema['name'], table['name'])
      
      # Delete all our fields for it (dependencies to table)
      sql = "DELETE FROM schema_table_field WHERE schema_table = %s" % table['id']
      print 'Deleting all fields: %s' % sql
      Query(cursor, sql)
      
      # Delete the table entry
      sql = "DELETE FROM schema_table WHERE id = %s" % table['id']
      print 'Deleting table entry: %s' % sql
      Query(cursor, sql)


def Main(args=None):
  if not args:
    args = []
  
  # Get our database cursor
  cursor = database.GetDatabaseCursor(SQLITE3_DATABASE_PATH)
  
  # Import all databases
  ImportOrRefreshAllDatabases(cursor)
  

if __name__ == '__main__':
  Main(sys.argv[1:])


