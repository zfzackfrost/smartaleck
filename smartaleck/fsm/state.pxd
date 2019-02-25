# cython: language_level=3, boundscheck=False

from smartaleck.core.agent cimport Agent

cdef class State:
    cdef readonly Agent owner_agent
    cdef readonly str state_name

    cpdef on_update(self, evt)

    cpdef on_enter(self)

    cpdef on_exit(self)
