use std::io;
use std::collections::VecDeque;
use std::collections::HashSet;

const START_OF_MESSAGE_UNIQ : usize = 14;

fn main() {
    let mut line = String::new();
    io::stdin().read_line(&mut line).unwrap();

    let mut last_four = VecDeque::new();
    let mut position = 0;
    for c in line.chars() {
        last_four.push_front(c);
        if last_four.len() > START_OF_MESSAGE_UNIQ {
            last_four.pop_back();
        } 

        if last_four.len() == START_OF_MESSAGE_UNIQ {
            if last_four.clone().into_iter().collect::<HashSet<_>>().into_iter().count() == START_OF_MESSAGE_UNIQ {
                println!("{}", position + 1);
                return;
            }
        }
        position += 1;
    }

    println!("");
}
