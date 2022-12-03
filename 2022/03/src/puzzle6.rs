use std::io;
use std::collections::HashSet;

extern crate itertools;
use itertools::Itertools;

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
    let mut lines = io::stdin().lines().peekable();
    let mut groups : Vec<(String, String, String)> = vec![];

    while lines.peek().is_some() {
        let lns = lines.next_tuple::<(Result<String, std::io::Error>, 
            Result<String, std::io::Error>, 
            Result<String, std::io::Error>)>().unwrap();
        let gs = (lns.0.unwrap(), lns.1.unwrap(), lns.2.unwrap());
        groups.push(gs);
    }

    let mut total_prio : u32 = 0;
    for g in groups {
        let mut sets: Vec<HashSet<u8>> = Vec::new();
        sets.push(g.0.as_bytes().iter().cloned().collect());
        sets.push(g.1.as_bytes().iter().cloned().collect());
        sets.push(g.2.as_bytes().iter().cloned().collect());
        let intersection = sets
            .iter()
            .skip(1)
            .fold(sets[0].clone(), |acc, hs| {
                acc.intersection(hs).cloned().collect()
            });


        total_prio += intersection.iter().map(|x| priority_of_item(*x)).sum::<u32>() as u32;
    }

    println!("{}", total_prio)
}
