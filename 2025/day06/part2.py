#!/usr/bin/env python3
import fileinput
from math import prod


def main():
    worksheet = []
    for line in fileinput.input():
        worksheet += [list(line)]

    # Transpose the worksheet so the last column is the first row.
    worksheet = list(zip(*worksheet))[::-1]

    grand_total = 0
    operands = []

    for line in worksheet:
        number_str = "".join(line[0:-1])
        if number_str.strip() == "":
            operands = []
            continue
        
        operands.append(int(number_str))

        if line[-1] == "*":
            grand_total += prod(operands)
        if line[-1] == "+":
            grand_total += sum(operands)
    
    print(grand_total)


main()
