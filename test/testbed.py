#!/usr/bin/env python
# -*- coding: utf-8 -*-

import time
from typing import Optional

import numpy as np

from smartaleck.core.agent import Agent
from smartaleck.core.event import EEventTarget, UpdateEvent
from smartaleck.core.world import World
from smartaleck.core.world_props import WorldProps
from smartaleck.fsm import StateMachine
from smartaleck.fsm.state import State


class TestAgent(Agent):
    def __init__(self, world: World):
        super().__init__(world)
        self._position = np.array([0.0] * self.world.vector_len)
        self._velocity = np.array([0.0] * self.world.vector_len)

    @property
    def position(self):
        return self._position

    @position.setter
    def position(self, new_pos):
        if len(new_pos) == self.world.vector_len:
            self._position = np.array(new_pos)

    @property
    def velocity(self):
        return self._velocity

    @velocity.setter
    def velocity(self, new_vel):
        if len(new_vel) == self.world.vector_len:
            self._velocity = np.array(new_vel)


class TestState(State):
    def __init__(self, state_name: str, owner_agent: Agent):
        super().__init__(state_name, owner_agent)

    def on_update(self, evt):
        super().on_update(evt)
        print(
            "    In State: {sname} \u2014 Event<target={etarget}>".format(
                sname=self.state_name, etarget=str(EEventTarget(evt.target).name)
            )
        )
        for i in range(10):
            np.sqrt(i)
        loop_count = (
            evt.user_data["loop_count"]
            if "loop_count" in evt.user_data
            else None
        )
        if loop_count is not None and loop_count == 5:
            return "last"
        return None

    def on_enter(self) -> None:
        print("    Enter State: {}".format(self.state_name))
        return None

    def on_exit(self) -> None:
        print("    Exit State: {}".format(self.state_name))
        return None


class TestFSM(StateMachine):
    def __init__(self, owner_agent: Agent):
        super().__init__(owner_agent)
        self.add_state(TestState, "start")
        self.add_state(TestState, "last")
        self.entry_state = "start"


def main():
    world = World(TestAgent)
    agent = TestAgent(world)

    fsm = TestFSM(agent)

    agent.position = [1, 10]
    agent.velocity = [100, 100]
    total_time = 0.0
    for _ in range(1):
        start = time.perf_counter()
        fsm.to_entry()
        for i in range(20):
            evt = UpdateEvent(
                delta_seconds=1 / 60.0,
                target=EEventTarget.GENERIC,
                user_data={"loop_count": i},
            )
            print("{}:".format(i))
            fsm.on_update(evt)
        end = time.perf_counter()
        delta = end - start
        total_time += delta

    print(total_time / 1.0)


if __name__ == "__main__":
    main()
