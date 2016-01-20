"""
Simple example Flask server.  Generic page renderer and dynamic page update RPC mechanism.
"""


import sys
import os
import sqlite3
import json

from flask import Flask
from flask import request
from flask import render_template
from flask import g as flask_dbi

# Custom module to wrap database related stuff
import database

# Rendering our custom web UI elements
import webui


# Are we debugging the web server?  Get tracebacks, has a console for testing expressions
DEBUG = True


# If we are in DEBUG mode, we want to protect our traffic, localhost only
if DEBUG:
  # Connections only on localhost (safer)
  SERVER_ADDRESS = '127.0.0.1'
# Else, we are not in DEBUG mode.  We can serve traffic from any interface (be careful, this may not be what you really want)
else:
  # Accept connections from all interfaces.  Could receive external traffic, like from the Internet.
  #SERVER_ADDRESS = '0.0.0.0'
  # Connections only on localhost (safer)   --    Protected, for demo purposes
  SERVER_ADDRESS = '127.0.0.1'


# SQLite 3 Database.  I wrote this as an example of an Comprehensive Authoritative Operational Database
DATABASE = 'database/opsdb.db'

# Flask server name
SERVER_NAME = 'slicuist_demo'

# Listening Port
SERVER_PORT = 5000

# Paths to our web content
STATIC_CUSTOM_PATH = 'web_static'       # Static content: Custom
STATIC_TEMPLATE_PATH = 'web_template'   # Static content: Bootstrap Template
TEMPLATE_PATH = 'templates'             # Dynamic templates


# -- Create the Flask server.  It is module level as we are going to use decorators against it for our module functions. --
SERVER = Flask(SERVER_NAME, template_folder=TEMPLATE_PATH)


class FileNotFoundException(Exception):
  """If we cant find a static file, this is thrown."""
  #TODO(g): Is this already in Flask, and I can just use their exceptions?  Check and replace.


@SERVER.route('/', methods=['GET', 'POST'])
def RenderIndex():
  """Render the index, which cant provide a path variable."""
  return RenderPage(request, '')


@SERVER.route('/<path:path>', methods=['GET', 'POST'])
def RenderPath(path):
  """Render any page that isn't an index, which provides us with a path.  
  
  Path allows slashes, but doesnt verify that any files exist or anything.
  """
  return RenderPage(request, path)


def RenderPage(server_request, path):
  """Every page is rendered exactly the same way.  Paths are irrelevant except as another data point."""
  # Set the index path, if we got nothing
  if not path:
    path = 'index.html'

  # Get the page from the path
  page = GetPageFromPath(server_request, path)
  
  # Dynamically render HTML pages, also RPC requests.  Anything we know about in the server (isnt just static)
  if page:
    # If you want to prefix the HTML pages in the TEMPLATE_PATH directory, so that formatting here.  Currently it's flat.
    template_path = page['path']
    
    # Any data we want to get into the templated path should go into this dict
    template_data = GetPathDataDict(server_request, page)
    
    print 'Templating: %s' % template_path
    
    return render_template(template_path, **template_data)

  # All other requests are static, and are not templated
  else:
    #NOTE(g): This should obviously be served from a static content server for performance.  This is for development.
    try:
      # Get the static content from our TEMPLATE_PATH first and STATIC_PATH if it doesnt exist in the template path
      static_path = GetStaticPath(path)
      
      content = open(static_path).read()  # Maximum typing efficiency and use of garbage collector!
      
      # Make a response object and set the MIME type so the content works in the browser
      response = SERVER.make_response(content)
      response.mimetype = GetPathMimeType(path)
      
      return response
    
    # GetStaticPath() throws this if it cant find a path in our dynamic templates or our static files
    except FileNotFoundException, e:
      #TODO(g): Handle this the Flask way, also use a template page instead of 1 sentance string
      response = SERVER.make_response('404: File not found: %s' % path)
      response.status_code = 404
      return response


def GetStaticPath(path):
  """Will try our template path, and fall back to our static path, so we have 
  options and our original content if we dont override it.
  """
  template_path = '%s/%s' % (TEMPLATE_PATH, path)                 # Try first
  static_custom_path = '%s/%s' % (STATIC_CUSTOM_PATH, path)       # Try second
  static_template_path = '%s/%s' % (STATIC_TEMPLATE_PATH, path)   # Try third

  # Return a valid path or raise an exception...
  if os.path.isfile(template_path):
    # It's one of our Template files
    return template_path
  
  # Static Custom
  elif os.path.isfile(static_custom_path):
    # It's a default static file (that we created for this probject, not from the base template)
    return static_custom_path
  
  # Static Template
  elif os.path.isfile(static_template_path):
    # It's a default static file (from our base template, that we havent modified at all)
    return static_template_path
  
  else:
    raise FileNotFoundException('Could not find: %s' % path)


def GetPageFromPath(server_request, path):
  """Returns the web_site_page dict for the specified request (site) and path (URI).
  
  Returns: dict or None
  """
  # Get SQLite3 database cursor
  cursor = database.GetDatabaseCursor(DATABASE)

  #TODO(g): Dont do this every time.  It's wasteful...  Mostly un-elegant, since its such a fast operation...
  database.populate_stats.PopulateSchemaStatistics(cursor)

  # Get the Hostname and the port for this server request
  if ':' in server_request.host:
    (hostname, port) = server_request.host.split(':', 1)
    port = int(port)
  
  else:
    hostname = server_request.host
    port = None
  
  print 'Hostname: %s' % server_request.host
  print 'Headers: %s' %  server_request.headers
  
  # Save the actual hostname, as we might have an XFF different hostname
  actual_hostname = hostname
  
  # Replace the hostname with the XFF, if it exists
  if 'X-Forwarded-For' in server_request.headers:
    hostname = server_request.headers['X-Forwarded-For']


  # Get the web_site -- Currently just getting any page that matches, this is not the full demo functionality
  #TODO(g): X-Forwarded-For (priority), or domain from the request.  Check them all.
  sql = "SELECT * FROM web_site_domain WHERE name = ?"
  web_site_domain_list = database.Query(cursor, sql, [hostname])
  
  # If we didnt find the web_site, we cant find this page
  if not web_site_domain_list:
    print 'ERROR: Web site for domain not found: %s' % hostname
    return None
  
  web_site_domain = web_site_domain_list[0]

  # Dyanmically get the page from the web_site and web_site_page
  sql = "SELECT * FROM web_site_page WHERE web_site = ? AND name = ?"
  pages = database.Query(cursor, sql, [web_site_domain['web_site'], path])
  
  # If we didnt find any page, just return empty data.  There is nothing to template.
  if not pages:
    return None
  
  # The first page is our page
  page = pages[0]
  
  return page


def GetPathDataDict(server_request, page):
  """Returns a dict of all the data needed to template a page."""
  data = {}

  # If we dont have a valid page, return empty data dict
  if not page:
    return {}

  # Get SQLite3 database cursor
  cursor = database.GetDatabaseCursor(DATABASE)
  
  
  # Generate the nav-bar from the web_site_map and web_site_map_items
  pass

  # Get the widgets for this page
  sql = "SELECT * FROM web_site_page_widget WHERE web_site_page = ? ORDER BY priority DESC"
  page_widgets = database.Query(cursor, sql, [page['id']])
  
  
  # Generate the Widgets for this Page
  for page_widget in page_widgets:
    # Get the widget data
    sql = "SELECT * FROM web_widget WHERE id = ?"
    widget_list = database.Query(cursor, sql, [page_widget['web_widget']])
    
    # Ensure we found the widget
    if not widget_list:
      print 'ERROR: Missing Widget, skipping: %s' % page_widget
    
    # Else, process the widget
    else:
      widget = widget_list[0]
      
      # Get the widget data from our JSON data
      widget_data = json.loads(page_widget['data_json'])
      
      # Render the widget from our HTML path, the page_widget name (element ID), and JSON data recorded as argument info from the page_widget_data
      #TODO(g): Will also need to pull in arguments, because sometimes we need page state to base on what the UI elements will deliver.  Add this in once the basic functinoality works.
      widget_output = webui.Render(server_request, cursor, widget, page_widget, widget_data, data)
      
      # Put the widget output into our data
      data[page_widget['name']] = widget_output
  
  
  # Template the widgets into the page, using their widget template names and their data_json for their data values.  Figure out all the table stuff...
  pass
  
  

  # Page static data
  data['page_title'] = page['title']

  # Page dynamic data

  sql = "SELECT * FROM service"
  rows = database.Query(cursor, sql)

  #sql = 'SELECT name FROM sqlite_master WHERE type = "table"'
  #rows = database.Query(cursor, sql)
  #
  #sql = 'PRAGMA table_info(schema)'
  #rows = database.Query(cursor, sql)


  data['test_data'] = str(rows)

  return data


def GetPathMimeType(path):
  """Determine the MIME type of this path"""
  suffix = path.lower().split('.')[-1]

  # Cheapo way to get some MIME types.  Could easily through this in a data file and skip the if/else chain and use a straight look-up
  #TODO(g): Does Flask already have a built-in or standard way to do this which is better?  Probably...  Replace.
  if suffix == 'css':
    return 'text/css'
  elif suffix == 'js':
    return 'text/js'
  elif suffix == 'png':
    return 'image/png'
  elif suffix == 'jpg':
    return 'image/jpeg'
  elif suffix == 'gif':
    return 'image/gif'
  else:
    return 'text'


@SERVER.teardown_appcontext
def CloseDatabaseConnection(exception):
  """Flask is shutting down the server, so close all the DB connections we have open."""
  database.CloseAll()


def Main(args=None):
  """Create the server.  Start it up."""
  global SERVER

  if not args:
    args = []
  
  SERVER.run(SERVER_ADDRESS, port=SERVER_PORT, debug=DEBUG)


if __name__ == '__main__':
    Main(sys.argv[1:])

