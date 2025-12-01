#!/usr/bin/env python3
import fileinput


def left(dial, positions):
    return (dial - positions) % 100

def right(dial, positions):
    return (dial + positions) % 100


def main():
    dial = 50
    zeros = 0
    for line in fileinput.input():
        positions = int(line[1:])
        if line.startswith('L'):
            dial = left(dial, positions)
        if line.startswith('R'):
            dial = right(dial, positions)
        if dial == 0:
            zeros += 1
    
    print("{}".format(zeros))


main()
