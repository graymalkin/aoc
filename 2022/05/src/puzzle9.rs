use std::io;
use std::collections::VecDeque;

extern crate regex;
use regex::Regex;

struct MoveCommand {
    qty: usize,
    src: usize,
    dst: usize
}

const NUM_STACKS : usize = 9;

fn main() {
    let lines = io::stdin().lines();
    let mut stacks : Vec<VecDeque<String>> = vec![VecDeque::new(); NUM_STACKS];
    let mut commands : Vec<MoveCommand> = vec![];
    let re_crate : Regex = Regex::new(r"\[[A-Z]\]").unwrap();
    let re_crates : Regex = Regex::new(r"(\[([A-Z])\]| ?( {3}))").unwrap();
    let re_crate_ids : Regex = Regex::new(r"^(( [0-9] ) ?)+$").unwrap();
    let re_seperator_id : Regex = Regex::new(r"^$").unwrap();
    let re_move_command : Regex = Regex::new(r"^move ([0-9]+) from ([0-9]) to ([0-9])$").unwrap();

    for line in lines {
        let ln = line.unwrap();
        if re_crates.is_match(&ln[..]) && !re_crate_ids.is_match(&ln[..]) {
            let mut id = 1;
            for mat in re_crates.find_iter(&ln[..]) {
                if re_crate.is_match(mat.as_str()) {
                    stacks[id - 1].push_front(mat.as_str()[1..2].to_string())
                }
                id += 1;
            }
        }

        if re_crate_ids.is_match(&ln[..]) {
        }

        if re_seperator_id.is_match(&ln[..]) {
        }

        if re_move_command.is_match(&ln[..]) {
            for cap in re_move_command.captures_iter(&ln[..]) {
                let cmd = MoveCommand {
                    qty: cap[1].parse::<usize>().unwrap(),
                    src: cap[2].parse::<usize>().unwrap(),
                    dst: cap[3].parse::<usize>().unwrap()
                };
                commands.push(cmd);
            }
        }
    }

    for MoveCommand { qty, src, dst } in commands {
        for _ in 0..qty {
            let crte = stacks[src - 1].pop_back().expect("");
            stacks[dst - 1].push_back(crte);
        }
    }

    let mut result = "".to_string();
    for stack in stacks {
        result.push_str(stack.get(stack.len()-1).expect(""));
    }

    
    println!("{}", result);
}
