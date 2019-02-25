"""Defines the SmartAleck `World` class & related types/methods

Author: Zachary Frost
Created: 2019-02-23
License: MIT
"""

from typing import Any, List, Type

import numpy as np

from smartaleck.core.agent import AbstractAgent
from smartaleck.core.world_props cimport WorldProps


class World(WorldProps):
    def __init__(self, agent_type, int vector_len = 2):
        super().__init__(vector_len)
        self.__agents__ = []
        self.__agent_type__ = agent_type

    @property
    def agents(self):
        return list(self.__agents__)
