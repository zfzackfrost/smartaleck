"""Defines the SmartAleck `World` class & related types/methods

Author: Zachary Frost
Created: 2019-02-23
License: MIT
"""

from smartaleck.core.agent cimport Agent
from smartaleck.core.world_props cimport WorldProps


cdef class World(WorldProps):
    cdef list __agents__
    cdef object __agent_type__
    def __init__(self, agent_type, int vector_len = 2):
        super().__init__(vector_len)
        self.__agents__ = []
        if issubclass(agent_type, Agent):
            self.__agent_type__ = agent_type
        else:
            self.__agent_type__ = Agent

    cpdef add_agent(self, agent_type):
        if issubclass(agent_type, self.__agent_type__):
            agent = agent_type(self)
            self.__agents__.append(agent)
            return agent
        return None

    @property
    def agents(self):
        return list(self.__agents__)
