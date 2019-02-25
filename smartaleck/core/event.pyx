# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck `Event` class & related types/methods

Author: Zachary Frost
Created: 2019-02-24
License: MIT
"""

from typing import Any, Dict, Optional


cpdef enum EventTrigger:
    NULL_TRIGGER = 0
    CUSTOM = 1
    UPDATE = 2


cpdef enum EventTarget:
    NULL_TARGET = 0
    GENERIC = 1
    AGENT = 2
    PATHFINDER = 3
    STATE_MACHINE = 4
    WORLD = 5


cdef class EventBase:
    cdef readonly EventTrigger trigger
    cdef readonly EventTarget target
    cdef readonly dict user_data
    def __init__(
        self,
        EventTrigger trigger = EventTrigger.NULL_TRIGGER,
        EventTarget target = EventTarget.NULL_TARGET,
        dict user_data = None,
    ):
        self.target = target
        self.trigger = trigger
        self.user_data = user_data

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Event Subclasses ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #


cdef class UpdateEvent(EventBase):
    cdef readonly float delta_seconds
    def __init__(
        self,
        float delta_seconds = -1.0,
        EventTarget target = EventTarget.NULL_TARGET,
        dict user_data = None,
    ):
        super().__init__(
            trigger=EventTrigger.UPDATE, target=target, user_data=user_data
        )
        self.delta_seconds = delta_seconds if delta_seconds >= 0.0 else 0.0
