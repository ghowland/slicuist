"""
Simple example Flask server
"""

import sys

from flask import Flask
from flask import request

# Create the Flask server.  It is module level as we are going to use decorators against it for our module functions.
SERVER = Flask(__name__)

#SERVER_ADDRESS = '0.0.0.0'	# All interfaces all connections
SERVER_ADDRESS = '127.0.0.1'	# Connections only on localhost (safer)

# Are we debugging the web server?  Get tracebacks, has a console for testing expressions
DEBUG = True


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

  output = 'Path: %s' % path

  return output


def Main(args=None):
  """Create the server.  Start it up."""
  global SERVER

  if not args:
    args = []
  
  SERVER.run(SERVER_ADDRESS, debug=DEBUG)


if __name__ == '__main__':
    Main(sys.argv[1:])

