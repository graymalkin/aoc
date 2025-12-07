#!/usr/bin/env python3
import fileinput
import functools

@functools.cache
def run_beam(r, c):
    for rn in range(r, len(tach_field)):
        if tach_field[rn][c] == "^":
            return run_beam(rn, c-1) + run_beam(rn, c+1)
    return 1

tach_field = [list(line.strip()) for line in fileinput.input()]
print(run_beam(0, tach_field[0].index("S")))
