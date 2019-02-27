# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck Finite State Machine's `State` class

Author: Zachary Frost
Created: 2019-02-24
License: MIT
"""

from smartaleck.core.agent cimport Agent
from smartaleck.core.event cimport UpdateEvent

cdef class State:
    def __init__(self, str state_name, Agent owner_agent not None):
        self.owner_agent = owner_agent
        self.state_name = state_name

    cpdef on_update(self, UpdateEvent evt):
        pass

    cpdef on_enter(self):
        pass

    cpdef on_exit(self):
        pass
