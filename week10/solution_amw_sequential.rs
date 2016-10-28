use std::fs::File;
use std::io::prelude::*;
use std::str;
use std::io::BufReader;
use std::collections::HashSet;
use std::ascii::AsciiExt;

static QD_MAP: [char; 26] = ['a', 'x', 'j', 'e', 'x', 'u', 'i', 'd', 'c', 'h', 't', 'n', 'm', 'b',
                             'r', 'l', 'x', 'p', 'o', 'y', 'g', 'k', 'x', 'q', 'f', 'x'];
fn main() {
    let file = File::open("/usr/share/dict/words").unwrap();

    let lines = BufReader::new(file).lines().map(|line| line.unwrap());
    let words: Vec<String> = lines.filter(|word| {
            !word.chars().any(|c| {
                c == 'q' || c == 'Q' || c == 'w' || c == 'W' || c == 'e' || c == 'E' || c == 'z' ||
                c == 'Z'
            })
        })
        .collect();
    let word_index: HashSet<String> = words.iter().cloned().collect();
    let mut results = String::new();
    for word in words {
        let converted = word.chars()
            .map(|c| QD_MAP[((c.to_ascii_lowercase() as u8) - 97) as usize])
            .collect::<String>();
        if let Some(_) = word_index.get(&converted) {
            results.push_str(format!("q:{}|d:{}\n", word, converted).as_str());
        }
    }

    let mut out_file = File::create("words.txt").unwrap();
    let bytes = results.as_bytes();
    out_file.write_all(bytes).unwrap();
}
