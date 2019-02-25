# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck `WorldProps` class & related types/methods

Author: Zachary Frost
Created: 2019-02-25
License: MIT
"""
cdef class WorldProps:
    cdef readonly int vector_len
