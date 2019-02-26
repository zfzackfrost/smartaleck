# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck event classes and related types

Author: Zachary Frost
Created: 2019-02-24
License: MIT
"""


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
    def __init__(
        self,
        EEventTrigger trigger = EEventTrigger.CUSTOM,
        EEventTarget target = EEventTarget.GENERIC,
        object user_data = None,
    ):
        self.target = target
        self.trigger = trigger
        self.user_data = dict(user_data)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Event Subclasses ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #


cdef class UpdateEvent(EventBase):
    cdef readonly float delta_seconds
    def __init__(
        self,
        float delta_seconds = -1.0,
        EEventTarget target = EEventTarget.GENERIC,
        dict user_data = None,
    ):
        super().__init__(
            trigger=EEventTrigger.UPDATE, target=target, user_data=user_data
        )
        self.delta_seconds = delta_seconds if delta_seconds >= 0.0 else 0.0
