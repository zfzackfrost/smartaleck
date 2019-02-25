# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck Finite State Machine's `State` class

Author: Zachary Frost
Created: 2019-02-24
License: MIT
"""

from smartaleck.core.agent import AbstractAgent
from smartaleck.fsm.state cimport *

cdef class State:
    def __init__(self, str state_name, owner_agent):
        self.__owner_agent__ = owner_agent
        self.state_name = state_name

    @property
    def owner_agent(self):
        return self.__owner_agent__

    cpdef on_update(self, evt):
        pass

    cpdef on_enter(self):
        pass

    cpdef on_exit(self):
        pass
