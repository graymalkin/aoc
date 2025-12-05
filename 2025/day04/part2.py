#!/usr/bin/env python3
import fileinput


def count_adjacent(x, y, map):
    bounds_x = len(map[0])
    bounds_y = len(map)
    count = 0
    for xi in [-1, 0, 1]:
        for yi in [-1, 0, 1]:
            if xi == 0 and yi == 0:
                continue

            if not (0 <= x + xi < bounds_x) or not (0 <= y + yi < bounds_y):
                continue

            if map[y + yi][x + xi] == "@":
                count += 1

    return count

def main():
    map = []
    for line in fileinput.input():
        map += [list(line.strip())]

    total_moved = 0
    movable_rolls = 1
    map_new = map
    while movable_rolls != 0:
        movable_rolls = 0
        for x in range(0, len(map[0])):
            for y in range(0,  len(map)):
                if map[y][x] == "@" and count_adjacent(x, y, map) < 4:
                    movable_rolls += 1
                    map_new[y][x] = "."
                else:
                    map_new[y][x] = map[y][x]
        total_moved += movable_rolls
        map = map_new

    print(total_moved)


main()
