"""
Handle basic SQLite 3 functions here, presenting a unified interface that 
other DBs could also follow to be transparently replaced (except for SQL 
differences).
"""

import sqlite3


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

