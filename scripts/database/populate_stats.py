"""
This is called to populate stats about this database, for demo purposes.

Stats are self-contained in the "opsdb.stats" table, which holds the name
of the statistic, the value and also the SQL statement for generting the
statistic value.

These can actually be any value generated by a SQL command, and assigned
into the "value" field, in the first row of output
"""


import __init__ as database
Query = database.Query


def PopulateSchemaStatistics(cursor):
  """Our demo needs stats which can be displayed, this function will generate them."""
  stats = Query(cursor, "SELECT * FROM stats")
  
  # Process and generate all of our stats
  for stat in stats:
    result = Query(cursor, stat['sql'])
    
    # If we got a valid result
    if result and 'value' in result[0]:
      sql = "UPDATE stats SET value = '%s' WHERE id = %s" % (result[0]['value'], stat['id'])
      print 'Updating Stat: %s == %s' % (stat['name'], result[0]['value'])
      Query(cursor, sql)
    
    # Else, we didnt get a valid result
    else:
      print 'Cannot generate stat: %s:  %s  -- Result:  %s' % (stat['name'], stat['sql'], result)