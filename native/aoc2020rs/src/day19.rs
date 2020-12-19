use pest::Parser;
use pest_derive::*;
use regex::Regex;

#[derive(Parser)]
#[grammar = "./day19.pest"]
pub struct Part1;

const INPUT: &str = include_str!("./day19_messages.txt");

pub fn part1() -> usize {
    INPUT
        .split('\n')
        .filter(|line| Part1::parse(Rule::d0, line).is_ok())
        .count()
}

pub fn prepare_input(input: &str) -> (String, String) {
    let mut split = input.split("\n\n");
    let grammar = split.next().unwrap();
    let messages = split.next().unwrap();
    assert_eq!(split.next(), None);

    // prefix digits with 'd'
    let digits = Regex::new(r"(\d+)").unwrap();
    let grammar = digits.replace_all(grammar, "d$1");

    // Insert the concat operator
    let concat = Regex::new(r"(d\d+) (d\d+)").unwrap();
    let grammar = concat.replace_all(&grammar, "$1 ~ $2");

    // add braces
    let braces = Regex::new(r": (.+)\n?").unwrap();
    let grammar = braces.replace_all(&grammar, ": { $1 }\n");

    // insert EOI
    let eoi = Regex::new(r"d0: \{ (.+) }\n").unwrap();
    let grammar = eoi.replace_all(&grammar, "d0: { $1 ~ EOI }\n");

    // replace : with =
    let grammar = grammar.replace(":", " =");

    (grammar, messages.to_string())
}
