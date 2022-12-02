use std::io;

#[derive(Clone, Copy)]
enum Move { Rock, Paper, Scissors }

#[derive(Clone, Copy)]
enum Result { Lose, Draw, Win }

fn pick_move(opponent : Move, result : Result) -> Move {
    match (opponent, result) {
        (Move::Rock, Result::Win) => Move::Paper,
        (Move::Rock, Result::Lose) => Move::Scissors,
        (Move::Paper, Result::Win) => Move::Scissors,
        (Move::Paper, Result::Lose) => Move::Rock,
        (Move::Scissors, Result::Win) => Move::Rock,
        (Move::Scissors, Result::Lose) => Move::Paper,
        (any, Result::Draw) => any
    }
}

fn score(opponent : Move, player : Move) -> u32 {
    const WIN : u32 = 6;
    const DRAW : u32 = 3;
    const LOSS : u32 = 0;

    let game_score = match (opponent, player) {
        (Move::Rock, Move::Paper) => WIN,
        (Move::Rock, Move::Scissors) => LOSS,
        (Move::Paper, Move::Scissors) => WIN,
        (Move::Paper, Move::Rock) => LOSS,
        (Move::Scissors, Move::Rock) => WIN,
        (Move::Scissors, Move::Paper) => LOSS,
        _ => DRAW
    };

    let move_score = match player {
        Move::Rock => 1, Move::Paper => 2, Move::Scissors => 3
    };

    return game_score + move_score;
}

pub fn main() {
    let lines = io::stdin().lines();
    let mut total_score : u32 = 0;

    for line in lines {
        let ln = line.unwrap();    
        let p1_move = match ln.chars().nth(0).unwrap() {
            'A' => Move::Rock, 'B' => Move::Paper, 'C' => Move::Scissors, _ => panic!("invalid move")
        };
        let p2_result = match ln.chars().nth(2).unwrap() {
            'X' => Result::Lose, 'Y' => Result::Draw, 'Z' => Result::Win, _ => panic!("invalid result")
        };
        let p2_move = pick_move(p1_move, p2_result);

        total_score += score(p1_move, p2_move);
    }

    println!("{}", total_score)
}