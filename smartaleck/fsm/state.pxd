# cython: language_level=3, boundscheck=False

from smartaleck.core.agent cimport Agent
from smartaleck.core.event cimport UpdateEvent

cdef class State:
    cdef readonly Agent owner_agent
    cdef readonly str state_name

    cpdef on_update(self, UpdateEvent evt)

    cpdef on_enter(self)

    cpdef on_exit(self)
