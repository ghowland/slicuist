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

# Database wrapper
import code
import code.database
Query = code.database.Query


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
  
  # Get all the tables
  existing_tables_list = Query(cursor, "SELECT * FROM schema_table WHERE schema = ?", [schema['id']])
  
  # Convert to dictionary keyed on the table name
  existing_tables = {d['name']: d for d in existing_tables_list}
  
  
  # Loop over each table
  for table in table_rows:
    # If the table isnt in the primary schema, add it
    if table['name'] not in existing_tables:
      pass
      print 'Adding table to schema: %s.%s' % (schema['name'], table['name'])
    
    # Get all the fields
    pass
    
    # Loop over all the fields
    if 1:
      # If this field isnt in the schema_table_field table, add it
      pass
      
      # Else, if this field is in the schema_table_field, but changed attributes, update them
      pass


def Main(args=None):
  if not args:
    args = []
  
  # Get our database cursor
  cursor = database.GetDatabaseCursor(SQLITE3_DATABASE_PATH)
  
  # Import all databases
  ImportOrRefreshAllDatabases(cursor)
  

if __name__ == '__main__':
  Main(sys.argv[1:])


