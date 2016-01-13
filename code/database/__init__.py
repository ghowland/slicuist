"""
Database Abstraction Module

Not a very interesting abstraction, but shim in other DBs here.
"""

import sqlite_wrapper

# There is only 1 kind of database at the moment (SQLite3), so I am providing 
#   some abstraction so this could be expanded, but I'm not going to put real
#   abstractions in place, as it would just clutter things and isn't necessary
#   for this demo to be a succeess.
from sqlite_wrapper import Query

