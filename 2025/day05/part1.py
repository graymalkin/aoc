#!/usr/bin/env python3
import fileinput


ID_RANGES = 0
INGREDIENTS = 1

def is_fresh(ingredient_id, fresh_id_ranges):
    for (start,end) in fresh_id_ranges:
        if ingredient_id in range(start, end+1):
            return True
    return False

def main():
    fresh_id_ranges = []
    ingredients = []
    parse_state = ID_RANGES
    for line in fileinput.input():
        if line.strip() == "":
            parse_state = INGREDIENTS
            continue

        if parse_state == ID_RANGES:
            parts = line.split('-')
            fresh_id_ranges.append((int(parts[0]), int(parts[1])))
        
        if parse_state == INGREDIENTS:
            ingredients.append(int(line))

    print(sum([is_fresh(id, fresh_id_ranges) for id in ingredients]))

main()
