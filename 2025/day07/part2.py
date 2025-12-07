#!/usr/bin/env python3
import fileinput


memoize_run_beam = dict()
def run_beam(tach_field, r, c):
    if (r, c) in memoize_run_beam:
        return memoize_run_beam.get((r,c))

    bounds_r = len(tach_field)
    bounds_c = len(tach_field[0])

    rn = r
    while rn < bounds_r:
        rn += 1
        if not rn < bounds_r or not 0 <= c < bounds_c:
            memoize_run_beam[(r,c)] = 1
            return 1
        if tach_field[rn][c] == "^":
            rec = run_beam(tach_field, rn, c-1) + run_beam(tach_field, rn, c+1)
            memoize_run_beam[(r,c)] = rec
            return rec


def main():
    tach_field = []
    for line in fileinput.input():
        tach_field += [list(line.strip())]

    print(run_beam(tach_field, 0, tach_field[0].index("S")))

main()
