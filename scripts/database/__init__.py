"""
Database Abstraction Module

Provides a layer to wrap different data sources, but for now only passes the
requests straight through.

Some changes to the API will likely be needed to make this a generic
interface, but this is sufficient for this demo.
"""


import sqlite_wrapper

# This Demonstration requires stats for the UI.  This module provides methods to generate them.
import populate_stats


# Global Cache for Database Connections, key is string of the connection path
DATABASE_CONNECTIONS = {}
DATABASE_CONNECTION_CURSORS = {}


def SanitizeSQL(sql_value):
  """Clean values before they are put into the database."""
  text = str(value)
  text = text.replace("'", "''")
  
  return text


def Connect(database_path):
  """Wrapper: Connect to database"""
  return sqlite_wrapper.Connect(database_path)


def GetCursor(database_connection):
  """Wrapper: Get database connection cursor"""
  return sqlite_wrapper.GetCursor(database_connection)


def Close(db):
  """Wrapper: Close connection"""
  #TODO(g): Remove from our cache.  This was legacy implementation and didnt have the cache yet.  Unify that.
  return sqlite_wrapper.Close(db)


def CloseAll():
  """Close all connections.  Removes them from the connection/cursor cache dict as well."""
  for key in DATABASE_CONNECTIONS.keys():
    Close(DATABASE_CONNECTIONS[key])
    
    # Remove from our cache
    del DATABASE_CONNECTIONS[key]
    del DATABASE_CONNECTION_CURSORS[key]


def Query(cursor, sql, params=None):
  """Wrapper: Query"""
  return sqlite_wrapper.Query(cursor, sql, params=params)


def GetDatabase(db_connection_value):
  """Get the database connection (singleton) and store it in Flask so it will be closed on server destruction.
  
  Defaults to the primary database, specified in our module level globals
  """
  global DATABASE_CONNECTIONS
  global DATABASE_CONNECTION_CURSORS
  
  # If we dont already have this connection cached, create it
  if db_connection_value not in DATABASE_CONNECTIONS:
    #TODO(g): SQLite3 is a local file, so interruptions are unlikely, and this is for demonstration purposes, not for production use.  For networked connections or just a resilient system in general, connection interruptions and re-connection logic must be added.
    #NOTE(g): This is not thread-safe dict accessing, and Flask runs with threads.  With our demo case, this is fine, but if more databases were added dynamically, collisions should occur.  Probably not an issue, as last-written would win and all attempts would succeed, but just noting this for completeness purposes.
    DATABASE_CONNECTIONS[db_connection_value] = Connect(db_connection_value)
    
    # Always create a cursor object as well.  We only need 1, and we will always need 1.
    DATABASE_CONNECTION_CURSORS[db_connection_value] = DATABASE_CONNECTIONS[db_connection_value].cursor()

  return DATABASE_CONNECTIONS[db_connection_value]


def GetDatabaseCursor(db_connection_value):
  """Gets the database connection's cursor for this DB connection key.
  
  Returns: DB Cursor
  """
  global DATABASE_CONNECTION_CURSORS
  
  # Ensure this database exists, by getting it
  db = GetDatabase(db_connection_value)
  
  # Return the cached cursor, which would have been populated by a previous GetDatabase() call
  return DATABASE_CONNECTION_CURSORS[db_connection_value]
