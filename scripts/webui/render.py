"""
Rendering Web Widgets
"""

import sys
sys.path.append('.')

import scripts.database as database


from jinja2 import Environment, FileSystemLoader


# Jinja docs recommend doing this.  Not sure if it's useful or not.  Will revisit later.
JINJA_ENVIRONMENT = Environment(loader=FileSystemLoader('.'), autoescape=False)


def Render(cursor, widget_data, page_widge_data, data):
  """This will render an HTML 'widget', or dynamic component in a page.

  Args:
    element_id: str, name of the HTML element (id attribute, typically in a DIV element, but could but other elements)
    data: dict, data that will be processed in the element by Jinja.  This is the Jinja input.
  """
  global JINJA_ENVIRONMENT

  html_path = widget_data['path']

  element_id = page_widge_data['name']

  # Determine if any values need to be looked up
  for (key, value) in data.items():
    # If this is a lookup
    #TODO(g): Should be a flag?  Or something more unique?  Want to avoid collisions with static data, but really already doing a lot of that
    if value.startswith('table.'):
      print 'Value: %s' % value
      (_, table_name, row_id, fieldname) = value.split('.')
      
      sql = "SELECT * FROM %s WHERE id = ?" % table_name
      rows = database.Query(cursor, sql, [row_id])
      
      #TODO(g): Handle error cases
      if rows:
        value = rows[0][fieldname]
        
        # Set the data key value to this new value
        data[key] = value


  # Use Jinja to get our template
  template = JINJA_ENVIRONMENT.get_template(html_path)

  # Insert the element ID into the data dictionary, as it is a normal 
  #   templating variable, but it is not part of our database table 
  #   data, as it is a layout element so separate
  data['element_id'] = element_id

  # Render our output from our template, and use the data dict as kwargs
  output = template.render(**data)

  return output

