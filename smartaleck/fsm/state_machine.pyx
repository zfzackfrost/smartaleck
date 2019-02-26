# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck Finite State Machine's `StateMachine` class

Author: Zachary Frost
Created: 2019-02-24
License: MIT
"""

from typing import Dict, Optional, Type, T

from smartaleck.core.agent cimport Agent

from smartaleck.fsm.state cimport State
from smartaleck.core import UpdateEvent

cdef class __CurrentStateOBJ__:
    cdef readonly State state
    cdef readonly bint is_entry
    def __cinit__(self, State state, bint is_entry):
        self.state = state
        self.is_entry = is_entry

cdef class StateMachine:
    cdef dict __states__
    cdef str __entry_state__
    cdef str __current_state__
    cdef Agent __owner_agent__
    def __cinit__(self, Agent owner_agent):
        self.__owner_agent__ = owner_agent
        self.__states__ = {}
        self.__entry_state__ = ""
        self.__current_state__ = ""


    cpdef to_entry(self):
        """Restart the state machine from the entry state.

        """
        self.current_state = self.entry_state

    cpdef State get_state(self, str state_name):
        if self.has_state(state_name):
            return self.__states__[state_name]
        return None

    def __getitem__(self, state_name: str):
        return self.get_state(state_name)

    @property
    def owner_agent(self):
        return self.__owner_agent__

    cpdef State add_state(
        self, state_type, str state_name
    ):
        cdef State state
        if state_name not in self.__states__:
            state = state_type(state_name, self.owner_agent)
            self.__states__[state_name] = state
            return state
        return None

    @property
    def current_state(self):
        return self.__current_state__

    @current_state.setter
    def current_state(self, new_current: str) -> None:
        if self.has_state(new_current):
            self.__current_state__ = new_current

    @property
    def entry_state(self) -> str:
        return self.__entry_state__

    @entry_state.setter
    def entry_state(self, new_entry: str) -> None:
        if self.has_state(new_entry):
            self.__entry_state__ = new_entry

    cpdef bint has_state(self, str state_name):
        return state_name in self.__states__

    @property
    def is_started(self):
        return True if self.__current_state__ else False

    cdef __CurrentStateOBJ__ __current_state_obj__(self):
        cdef bint is_entry
        is_entry = False
        if not self.is_started:
            is_entry = True
            if not self.has_state(self.entry_state):
                raise RuntimeError(
                    "Could not find a state object for entry state name!"
                )
            else:
                self.current_state = self.entry_state
        if not self.has_state(self.current_state):
            raise RuntimeError(
                "Could not find a state object for current state name!"
            )

        return __CurrentStateOBJ__(self.__states__[self.current_state], is_entry)

    cpdef on_update(self, evt):
        cdef State state_obj, next_state_obj
        cdef str next_state_name
        cdef bint is_entry
        cdef __CurrentStateOBJ__ state_obj_result
        state_obj_result = self.__current_state_obj__()
        state_obj = state_obj_result.state
        is_entry = state_obj_result.is_entry
        if is_entry:
            state_obj.on_enter()
        next_state_name = state_obj.on_update(evt)
        if next_state_name is not None and self.has_state(next_state_name):
            state_obj.on_exit()
            next_state_obj = self.get_state(next_state_name)
            if isinstance(next_state_obj, State):
                next_state_obj.on_enter()
                self.current_state = next_state_name
