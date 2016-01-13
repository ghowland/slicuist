"""
Simple example Flask server
"""


import sys
import os

from flask import Flask
from flask import request
from flask import render_template


# Are we debugging the web server?  Get tracebacks, has a console for testing expressions
DEBUG = True

# Flask server name
SERVER_NAME = 'slocust_demo'

#SERVER_ADDRESS = '0.0.0.0'	# All interfaces all connections
SERVER_ADDRESS = '127.0.0.1'	# Connections only on localhost (safer)

# Paths
STATIC_PATH = 'web_template'
TEMPLATE_PATH = 'templates'

# -- Create the Flask server.  It is module level as we are going to use decorators against it for our module functions. --
#SERVER = Flask(SERVER_NAME, static_folder=STATIC_PATH, template_folder=TEMPLATE_PATH)
SERVER = Flask(SERVER_NAME, template_folder=TEMPLATE_PATH)


class FileNotFoundException(Exception):
  """If we cant find a static file, this is thrown."""


@SERVER.route('/', methods=['GET', 'POST'])
def RenderIndex():
  """Render the index, which cant provide a path variable."""
  return RenderPage('')


@SERVER.route('/<path:path>', methods=['GET', 'POST'])
def RenderPath(path):
  """Render any page that isn't an index, which provides us with a path.  
  
  Path allows slashes, but doesnt verify that any files exist or anything.
  """
  return RenderPage(path)


def RenderPage(path):
  # Set the index path, if we got nothing
  if not path:
    path = 'index.html'

  # Dynamically render HTML pages
  if path.endswith('.html'):
    # If you want to prefix the HTML pages in the TEMPLATE_PATH directory, so that formatting here.  Currently it's flat.
    template_path = path

    # Any data we want to get into the templated path should go into this dict
    template_data = GetPathDataDict(path)

    return render_template(template_path, **template_data)

  # All other requests are static, and are not templated
  else:
    try:
      # Get the static content from our TEMPLATE_PATH first and STATIC_PATH if it doesnt exist in the template path
      static_path = GetStaticPath(path)

      content = open(static_path).read()  # Maximum typing efficiency and use of garbage collector!

      # Make a response object and set the MIME type so the content works in the browser
      response = SERVER.make_response(content)
      response.mimetype = GetPathMimeType(path)

      return response

    except FileNotFoundException, e:
      #TODO(g): Handle this the Flask way, also use a template page instead of 1 sentance string
      response = SERVER.make_response('404: File not found: %s' % path)
      response.status_code = 404
      return response


def GetStaticPath(path):
  """Will try our template path, and fall back to our static path, so we have 
  options and our original content if we dont override it.
  """
  template_path = '%s/%s' % (TEMPLATE_PATH, path)   # Try first
  static_path = '%s/%s' % (STATIC_PATH, path)       # Try second

  if os.path.isfile(template_path):
    return template_path
  elif os.path.isfile(static_path):
    return static_path
  else:
    raise FileNotFoundException('Could not find: %s' % path)


def GetPathDataDict(path):
  """Returns a dict of all the data needed to template a page."""
  data = {}

  return data


def GetPathMimeType(path):
  """Determine the MIME type of this path"""
  suffix = path.lower().split('.')[-1]

  # Cheapo way to get some MIME types
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


def Main(args=None):
  """Create the server.  Start it up."""
  global SERVER

  if not args:
    args = []
  
  SERVER.run(SERVER_ADDRESS, debug=DEBUG)


if __name__ == '__main__':
    Main(sys.argv[1:])

