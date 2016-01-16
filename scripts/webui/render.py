"""
Rendering Web Widgets
"""

from jinja2 import Environment, PackageLoader


# Jinja docs recommend doing this.  Not sure if it's useful or not.  Will revisit later.
JINJA_ENVIRONMENT = Environment(loader=PackageLoader('SLoWCUST Demo', 'templates'))


def Render(html_path, element_id, data):
  """This will render an HTML 'widget', or dynamic component in a page.

  Args:
    element_id: str, name of the HTML element (id attribute, typically in a DIV element, but could but other elements)
    data: dict, data that will be processed in the element by Jinja.  This is the Jinja input.
  """
  global JINJA_ENVIRONMENT

  # Use Jinja to get our template
  JINJA_ENVIRONMENT.get_template(html_path)

  # Insert the element ID into the data dictionary, as it is a normal 
  #   templating variable, but it is not part of our database table 
  #   data, as it is a layout element so separate
  data['element_id'] = element_id

  # Render our output from our template, and use the data dict as kwargs
  output = template.render(**data)

  return output

