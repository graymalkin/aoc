#!/usr/bin/env python3
import fileinput
from math import prod


def main():
    tach_field = []
    for line in fileinput.input():
        tach_field += [list(line.strip())]

    bounds_r = len(tach_field)
    bounds_c = len(tach_field[0])
    workqueue = [(0, tach_field[0].index("S"))]
    split_points = set()

    while len(workqueue) > 0:
        r, c = workqueue.pop()
        if r + 1 >= bounds_r or not 0 <= c < bounds_c:
            continue
        match tach_field[r+1][c]:
            case '.':
                tach_field[r+1][c] = '|'
                workqueue.append((r+1, c))
            case '^':
                for (rn, cn) in [(r+1, c+1), (r+1, c-1)]:
                    tach_field[rn][cn] = '|'
                    split_points.add((rn,cn))
                    workqueue.append((rn, cn))

    print(len(split_points))


main()
