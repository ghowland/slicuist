"""
Simple example Flask server
"""

import sys
import flask

SERVER = flask.Flask(__name__)

#SERVER_ADDRESS = '0.0.0.0'	# All interfaces all connections
SERVER_ADDRESS = '127.0.0.1'	# Connections only on localhost (safer)


@SERVER.route('/')
def hello_world():
    return 'Hello World!'


def Main(args=None):
  global SERVER

  if not args:
    args = []
  
  SERVER.run(SERVER_ADDRESS)


if __name__ == '__main__':
    Main(sys.argv[1:])

