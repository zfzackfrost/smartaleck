
# cython: language_level=3, boundscheck=False
cdef class State:
    cdef readonly str state_name

    cpdef on_update(self, evt)

    cpdef on_enter(self)

    cpdef on_exit(self)
