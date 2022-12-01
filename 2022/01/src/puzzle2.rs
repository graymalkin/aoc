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

    elves.sort_by(|a, b| {
        let a_kcal : u32 = a.food_items;
        let b_kcal : u32 = b.food_items;
        b_kcal.partial_cmp(&a_kcal).unwrap()
    });

    let mut total_kcal = 0;
    for elf in &elves[0..3] {
        total_kcal += elf.food_items;
    }

    println!("{}", total_kcal)
}
