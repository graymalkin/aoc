#!/usr/bin/env python3
import fileinput
import functools
import operator
from itertools import groupby


def highest_joltage(bank):
    pos_highest = 0
    val_highest = 0
    for i in range(0, len(bank) - 1):
        if bank[i] > val_highest:
            pos_highest = i
            val_highest = bank[i]
    
    tens = val_highest
    bank = bank[pos_highest+1:]

    pos_highest = 0
    val_highest = 0
    for i in range(0, len(bank)):
        if bank[i] > val_highest:
            pos_highest = i
            val_highest = bank[i]
    units = val_highest

    return 10*tens + units

def main():
    input_data = []
    highest_per_bank = []
    for line in fileinput.input():
        bank = [int(i) for i in line.strip()]
        input_data.append(bank)
        highest = highest_joltage(bank)
        highest_per_bank.append(highest)
    
    print(functools.reduce(operator.add, highest_per_bank, 0))

main()
