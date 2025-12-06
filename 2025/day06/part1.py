#!/usr/bin/env python3
import fileinput
from math import prod


def main():
    worksheet = []
    for line in fileinput.input():
        worksheet += [line.split()]

    grand_total = 0
    for c in range(len(worksheet[0])):
        math_problem = [int(worksheet[r][c]) for r in range(len(worksheet) - 1)]
        if worksheet[-1][c] == '+':
            grand_total += sum(math_problem)
        elif worksheet[-1][c] == '*':
            grand_total += prod(math_problem)

    print(grand_total)


main()
