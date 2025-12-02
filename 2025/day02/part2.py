#!/usr/bin/env python3
import fileinput


def is_valid(s):
    l = len(s)

    for parts in range(1,l):
        if l % parts != 0:
            continue
        
        id_parts = [s[i:i+parts] for i in range(0, l, parts)]
        eq_first = []
        for p in id_parts:
            eq_first.append(p == id_parts[0])
        if all(eq_first):
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