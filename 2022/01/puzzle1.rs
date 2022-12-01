use std::io;

struct Elf {
    food_items: Vec<u32>
}

fn main() {
    let mut elves = vec![Elf { food_items: vec![] }];
    let lines = io::stdin().lines();

    for line in lines {
        match line.unwrap().parse::<u32>() {
            Ok (kcal) => { elves.last_mut().unwrap().food_items.push(kcal) }
            Err (_) => { elves.push(Elf { food_items: vec![] }) }
        }
    }

    let highest_elf = elves.iter().fold(&elves[0], |max_elf, curr_elf| {
        let max_elf_kcal : u32 = max_elf.food_items.iter().sum::<u32>();
        let curr_elf_kcal : u32 = curr_elf.food_items.iter().sum::<u32>();
        if curr_elf_kcal > max_elf_kcal { &curr_elf }
        else { &max_elf }
    });
    println!("{}", highest_elf.food_items.iter().sum::<u32>())
}
