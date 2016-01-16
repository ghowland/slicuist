"""
Handle basic SQLite 3 functions here, presenting a unified interface that 
other DBs could also follow to be transparently replaced (except for SQL 
differences).
"""


import sqlite3


def Connect(database_path):
  """Returns sqlite3 Database Connection object."""
  # Connect, parse the column names and the data types
  db = sqlite3.connect(database_path, detect_types=sqlite3.PARSE_DECLTYPES|sqlite3.PARSE_COLNAMES)

  # Allow accessing the rows with column indexes or column field names (case-insensitive)
  db.row_factory = sqlite3.Row
  
  return db


def GetCursor(database_connection):
  """Get database connection cursor"""
  cursor = database_connection.cursor()
  
  return cursor


def Close(db):
  """Takes a SQLite3 Database object and closes the connection.  Returns None."""
  db.close()


def Query(cursor, sql, params=None):
  """Query against the Cursor.  Params will be formatted into the sql query string if present.

  Returns: list of dicts
  """
  if not params:
    cursor.execute(sql)
  else:
    cursor.execute(sql, params)

  # Get the SQLite object rows
  object_rows = cursor.fetchall()

  # Convert the object rows into dicts for my preferred usage (requires setting connection:  conn.row_factory = sqlite3.Row)
  rows = []
  for row in object_rows:
    rows.append(dict(row))

  return rows

