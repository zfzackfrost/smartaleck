# cython: language_level=3, boundscheck=False
"""Defines the SmartAleck `Agent` class & related types/methods

Author: Zachary Frost
Created: 2019-02-23
License: MIT
"""
from abc import ABC, abstractmethod

import numpy as np

cimport smartaleck.core.world_props as world_props

cdef class AbstractAgentBase:
    def __init__(self, world_props.WorldProps world):
        super().__init__()
        self.__world__ = world

    @property
    def world(self):
        return self.__world__

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

class AbstractAgent(AbstractAgentBase):
    pass
