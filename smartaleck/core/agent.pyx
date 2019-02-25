# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck `Agent` class & related types/methods

Author: Zachary Frost
Created: 2019-02-23
License: MIT
"""


from smartaleck.core.world_props cimport WorldProps

cdef class Agent:
    def __init__(self, WorldProps world):
        self.world = world

    @property
    def position(self):
        return [0.0] * self.world.vector_len

    @position.setter
    def position(self, new_pos):
        pass

    @property
    def velocity(self):
        return [0.0] * self.world.vector_len

    @velocity.setter
    def velocity(self, new_vel):
        pass

