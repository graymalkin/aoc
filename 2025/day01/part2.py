#!/usr/bin/env python3
import fileinput


def left(clicks, dial, positions):
    while positions > 0:
        positions -= 1
        dial -= 1
        if dial == 0:
            clicks += 1
        dial %= 100

    return (clicks, dial)

def right(clicks, dial, positions):
    while positions > 0:
        positions -= 1
        dial += 1
        if dial == 100:
            clicks += 1
        dial %= 100

    return (clicks, dial)

def main():
    dial = 50
    clicks = 0
    for line in fileinput.input():
        positions = int(line[1:])
        if line.startswith('L'):
            clicks, dial = left(clicks, dial, positions)
        if line.startswith('R'):
            clicks, dial = right(clicks, dial, positions)
    
    print("{}".format(clicks))


main()
