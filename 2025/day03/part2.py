#!/usr/bin/env python3
import fileinput
import time


def highest_joltage(num_batteries, bank):
    joltage = 0
    for bat in range(num_batteries, 0, -1):
        pos_highest = 0
        val_highest = 0
        for i in range(0, len(bank) - bat + 1):
            if bank[i] > val_highest:
                pos_highest = i
                val_highest = bank[i]
        
        joltage = joltage*10 + val_highest
        bank = bank[pos_highest+1:]

    return joltage

def main():
    total_joltage = 0
    for line in fileinput.input():
        bank = [int(i) for i in line.strip()]
        total_joltage += highest_joltage(12, bank)
    
    print(total_joltage)

main()
