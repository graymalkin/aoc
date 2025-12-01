#!/usr/bin/env python3
import fileinput


def left(clicks, dial, positions):
    """
    This is broken, and I cannot figure out how to fix it nicely.
    """
    dial_new = (dial - positions) % 100
    extra_clicks = (dial_new + positions) // 100

    return (clicks + extra_clicks, dial_new)

def right(clicks, dial, positions):
    dial_new = (dial + positions) % 100
    extra_clicks = (dial + positions) // 100

    return (clicks + extra_clicks, dial_new)

def main():
    dial = 50
    clicks = 0
    for line in fileinput.input():
        positions = int(line[1:])
        if line.startswith('L'):
            clicks, dial = left(clicks, dial, positions)
        if line.startswith('R'):
            clicks, dial = right(clicks, dial, positions)
        print("{:4s} {:02d} {:04d}".format(line.strip(), clicks, dial))
    
    print("{}".format(clicks))


main()
