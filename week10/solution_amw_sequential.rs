use std::fs::File;
use std::io::prelude::*;
use std::str;
use std::io::BufReader;
use std::collections::HashSet;
use std::ascii::AsciiExt;

static QD_MAP: [char; 26] = [
    'a',
    'x',
    'j',
    'e',
    'x', // e, bad
    'u',
    'i',
    'd',
    'c',
    'h',
    't',
    'n',
    'm',
    'b',
    'r',
    'l',
    'x', //q, bad
    'p',
    'o',
    'y',
    'g',
    'k',
    'x', //w, bad
    'q',
    'f',
    'x', //z bad
];
fn main() {
    let file = File::open("/usr/share/dict/words").unwrap();
    let words: Vec<String> = BufReader::new(file).lines().map(|line| line.unwrap()).filter(|word|
                                                                                           !word.chars().any(|c|
                                                                                                             c == 'q' || c == 'Q' || c == 'w' || c == 'W' ||
                                                                                                             c == 'e' || c == 'E' || c == 'z' || c == 'Z')
    ).collect();

    let word_index: HashSet<String> = words.iter().cloned().collect();
    let mut results = vec!();
    for word in words {
        let converted = word.chars().map(|c|
                                         QD_MAP[((c.to_ascii_lowercase() as u8) - 97) as usize]
        ).collect::<String>();
        if let Some(_) =  word_index.get(&converted) {
            results.push(format!("q:{}|d:{}", word, converted));
        }
    }


    let mut out_file = File::create("words.txt").unwrap();
    let str = results.join("\n");
    let bytes = str.as_bytes();
    out_file.write_all(bytes).unwrap();
}
