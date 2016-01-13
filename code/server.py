"""
Simple example Flask server
"""

import sys

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
    template_path = 'pages/%s' % path

    # Any data we want to get into the templated path should go into this dict
    template_data = GetPathDataDict(path)

    return render_template(template_path, **template_data)

  # All other requests are static, and are not templated
  else:
    static_path = '%s/%s' % (STATIC_PATH, path)

    return open(static_path).read()  # Maximum efficiency and use of garbage collection!



def GetPathDataDict(path):
  """Returns a dict of all the data needed to template a page."""
  data = {}

  return data


def Main(args=None):
  """Create the server.  Start it up."""
  global SERVER

  if not args:
    args = []
  
  SERVER.run(SERVER_ADDRESS, debug=DEBUG)


if __name__ == '__main__':
    Main(sys.argv[1:])

