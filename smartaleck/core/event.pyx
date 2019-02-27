# cython: language_level=3, boundscheck=False, language=c++
"""Defines the SmartAleck event classes and related types

Author: Zachary Frost
Created: 2019-02-24
License: MIT
"""

from smartaleck.core.event cimport EEventTrigger, EEventTarget

cdef class EventBase:
    def __cinit__(
        self,
        EEventTrigger trigger=EEventTrigger.CUSTOM,
        EEventTarget target=EEventTarget.GENERIC,
        dict user_data=None,
        **kwargs,
    ):
        self.target = target
        self.trigger = trigger
        self.user_data = user_data

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Event Subclasses ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #


cdef class UpdateEvent(EventBase):
    def __cinit__(
        self,
        float delta_seconds=-1.0,
        EEventTarget target=EEventTarget.GENERIC,
        dict user_data=None,
        **kwargs,
    ):
        self.target = target
        self.trigger = EEventTrigger.UPDATE
        self.user_data = user_data
        self.delta_seconds = delta_seconds if delta_seconds >= 0.0 else 0.0
