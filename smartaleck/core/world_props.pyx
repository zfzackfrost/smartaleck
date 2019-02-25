# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck `WorldProps` class & related types/methods

Author: Zachary Frost
Created: 2019-02-24
License: MIT
"""


cdef class WorldProps:
    def __init__(self, int vector_len = 2):
        self.vector_len = vector_len

