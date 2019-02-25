# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck `Agent` class & related types/methods

Author: Zachary Frost
Created: 2019-02-23
License: MIT
"""

from smartaleck.core.world_props cimport WorldProps
cdef class Agent:
    cdef readonly WorldProps world
