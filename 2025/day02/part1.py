#!/usr/bin/env python3
import fileinput


def is_valid(s):
    l = len(s)

    # Odd lengths are always valid
    if l % 2 == 1:
        return True

    if s[0:(l//2)] == s[(l//2):]:
        return False

    return True

def main():
    input_data = ""
    for line in fileinput.input():
        input_data += line.strip()

    sum = 0
    for entry in input_data.split(','):
        start = int(entry.split('-')[0])
        end = int(entry.split('-')[1])
        for id in range(start, end+1):
            if not is_valid(str(id)):
                sum += id

    print(sum)

main()