# cython: language_level=3, boundscheck=False, language=c++
"""Defines the SmartAleck event classes and related types

Author: Zachary Frost
Created: 2019-02-26
License: MIT
"""

from libcpp.map cimport map


cpdef enum EEventTrigger:
    CUSTOM = 1
    UPDATE = 2

cpdef enum EEventTarget:
    GENERIC = 1
    AGENT = 2
    PATHFINDER = 3
    STATE_MACHINE = 4
    WORLD = 5

cdef class EventBase:
    cdef readonly EEventTrigger trigger
    cdef readonly EEventTarget target
    cdef readonly dict user_data

cdef class UpdateEvent(EventBase):
    cdef readonly float delta_seconds
