use std::io;
use std::ops::Range;

fn ranges_overlap(r1 : &Range<u32>, r2 : &Range<u32>) -> bool {
    return (r1.start >= r2.start && r1.end <= r2.end)
        || (r2.start >= r1.start && r2.end <= r1.end)
}

fn main() {
    let lines = io::stdin().lines();
    let mut joblist = vec![];

    for line in lines {
        let ln = line.unwrap();
        let parts = ln.split(',');

        let first = parts.clone().nth(0).expect("require elf jobs");
        let mut first_indexes = first.split('-');
        let elf1 = Range {
            start: first_indexes.clone().nth(0).expect("").parse::<u32>().unwrap(),
            end: first_indexes.nth(1).expect("").parse::<u32>().unwrap(),
        };

        let second = parts.clone().nth(1).expect("require elf jobs");
        let mut second_indexes = second.split('-');
        let elf2 = Range {
            start: second_indexes.clone().nth(0).expect("").parse::<u32>().unwrap(),
            end: second_indexes.nth(1).expect("").parse::<u32>().unwrap(),
        };

        joblist.push((elf1, elf2));
    }

    let overlaps = joblist.iter().filter(|(e1,e2)| ranges_overlap(e1,e2)).count();
    println!("{}", overlaps);
}
