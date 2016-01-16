"""
Handles rendering all the templated HTML/JS chunks, so they can be injected into the page.

For a given page, on initial render, all of these are called to render the page.  Afterwards they can be called individually or in groups to only update parts of the page.
"""

from render import Render

