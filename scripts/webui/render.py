"""
Rendering Web Widgets
"""

import sys
sys.path.append('.')

import scripts.database as database


from jinja2 import Environment, FileSystemLoader


# Jinja docs recommend doing this.  Not sure if it's useful or not.  Will revisit later.
JINJA_ENVIRONMENT = Environment(loader=FileSystemLoader('.'), autoescape=False)


def Render(server_request, cursor, widget_data, page_widget_data, data):
  """This will render an HTML 'widget', or dynamic component in a page.

  Args:
    element_id: str, name of the HTML element (id attribute, typically in a DIV element, but could but other elements)
    data: dict, data that will be processed in the element by Jinja.  This is the Jinja input.
  """
  global JINJA_ENVIRONMENT

  html_path = widget_data['path']

  element_id = page_widget_data['name']

  # Determine if any values need to be looked up
  for (key, value) in data.items():
    # If this is a table lookup
    if value.startswith('__table.'):
      print 'Value: %s' % value
      (_, table_name, row_id, fieldname) = value.split('.')
      
      sql = "SELECT * FROM %s WHERE id = ?" % table_name
      rows = database.Query(cursor, sql, [row_id])
      
      #TODO(g): Handle error cases
      if rows:
        value = rows[0][fieldname]
        
        # Set the data key value to this new value
        data[key] = value
    
    
    # Else, if this is getting all the rows from a table
    elif value.startswith('__rows.'):
      print 'Value: %s' % value
      (_, table_name) = value.split('.', 1)
      
      # If this is a lookup from our args, do the lookup
      if table_name.startswith('{') and table_name.endswith('}'):
        lookup = table_name.split('{', 1)[1]
        lookup = lookup.split('}', 1)[0]
        
        sql = "SELECT * FROM schema_table WHERE id = ?"
        print 'Table Lookup SQL: %s: %s' % (sql, server_request.args[lookup])
        table_list = database.Query(cursor, sql, [server_request.args[lookup]])
        
        if not table_list:
          raise Exception('Couldnt find schema table ID: %s: %s' % (lookup, value))
        
        #TODO(g): Ensure we are working with the correct schema (database), currently there is only 1, so it is always correct, but this is made to work with multiple datasources, so it might not be the same one and this would be casting too wide a search by not limiting it to the correct schema first...
        pass
        
        table_name = table_list[0]['name']
      
      sql = "SELECT * FROM %s" % table_name
      rows = database.Query(cursor, sql)
      
      print 'Rows: %s' % rows
      
      # Set the data key value the rows
      data[key] = rows
    
    
    # Else, if this is getting all the fields from a table
    elif value.startswith('__fields.'):
      print 'Value: %s' % value
      (_, table_name) = value.split('.')
      
      sql = "SELECT * FROM schema_table WHERE name = ?"
      table_list = database.Query(cursor, sql, [table_name])
      
      #TODO(g): Handle failure to find this table with error/messages/etc, for now assuming success
      if table_list:
        table = table_list[0]
        
        sql = "SELECT * FROM schema_table_field WHERE schema_table = ? ORDER BY column_order"
        fields = database.Query(cursor, sql, [table['id']])
        
        print 'Fields: %s' % fields
        
        # Do a little fix-up on the label_default, if it is NULL.  Auto-formatting based on the 'name' field
        for field in fields:
          if field['label_default'] == None:
            # Underscores into spaces and upper case the first letter of every word
            field['label_default'] = field['name'].replace('_', ' ')
            
            words = field['label_default'].split(' ')
            for count in range(0, len(words)):
              words[count] = words[count][0].upper() + words[count][1:].lower()
            
            field['label_default'] = ' '.join(words)
        
        # Set the data key value the fields
        data[key] = fields


  # Use Jinja to get our template
  template = JINJA_ENVIRONMENT.get_template(html_path)

  # Insert the element ID into the data dictionary, as it is a normal 
  #   templating variable, but it is not part of our database table 
  #   data, as it is a layout element so separate
  data['element_id'] = element_id

  # Render our output from our template, and use the data dict as kwargs
  output = template.render(**data)

  return output

