use std::io;

struct Elf {
    food_items: u32
}

fn main() {
    let mut elves = vec![Elf { food_items: 0 }];
    let lines = io::stdin().lines();

    for line in lines {
        match line.unwrap().parse::<u32>() {
            Ok (kcal) => { elves.last_mut().unwrap().food_items += kcal }
            Err (_) => { elves.push(Elf { food_items: 0 }) }
        }
    }

    let highest_elf = elves.iter().fold(&elves[0], |max_elf, curr_elf| {
        let max_elf_kcal : u32 = max_elf.food_items;
        let curr_elf_kcal : u32 = curr_elf.food_items;
        if curr_elf_kcal > max_elf_kcal { &curr_elf }
        else { &max_elf }
    });
    println!("{}", highest_elf.food_items)
}
