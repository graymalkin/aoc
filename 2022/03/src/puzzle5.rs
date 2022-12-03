use std::io;
use std::collections::HashSet;
use std::iter::FromIterator;

fn priority_of_item(x : u8) -> u32 {
    if x >= ('a' as u8) && x <= ('z' as u8) {
        return ((x as u8) - ('a' as u8) + 1).into()
    }
    if x >= ('A' as u8) && x <= ('Z' as u8) {
        return ((x as u8) - ('A' as u8) + 27).into()
    }
    panic!("invalid item")
}

fn main() {
    let lines = io::stdin().lines();
    let mut backpacks : Vec<(String, String)> = vec![];

    for line in lines {
        let ln = line.unwrap();
        let fc = String::from(&ln[0..ln.len()/2]);
        let bc = String::from(&ln[ln.len()/2..ln.len()]);
        backpacks.push((fc, bc));
    }

    let mut total_prio : u32 = 0;
    for bp in backpacks {
        let a : HashSet<&u8, std::collections::hash_map::RandomState> = HashSet::from_iter(bp.0.as_bytes());
        let b = HashSet::from_iter(bp.1.as_bytes());
        let inter = a.intersection(&b);
        total_prio += inter.map(|x| priority_of_item(**x)).sum::<u32>() as u32;
    }

    println!("{}", total_prio)
}