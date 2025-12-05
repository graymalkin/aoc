#!/usr/bin/env python3
import fileinput


ID_RANGES = 0
INGREDIENTS = 1

def main():
    fresh_id_ranges = []
    ingredients = []
    parse_state = ID_RANGES
    for line in fileinput.input():
        if line.strip() == "":
            parse_state = INGREDIENTS
            break

        if parse_state == ID_RANGES:
            parts = line.split('-')
            fresh_id_ranges.append((int(parts[0]), int(parts[1])))
        
        if parse_state == INGREDIENTS:
            ingredients.append(int(line))

    highest_start = 0
    total_fresh = 0
    fresh_id_ranges.sort(key=lambda r: r[0])
    for (start, end) in fresh_id_ranges:
        s = max(highest_start, start)
        e = end+1
        total_fresh += len(range(s, e))
        highest_start = max(s, e)

    print(total_fresh)

main()
