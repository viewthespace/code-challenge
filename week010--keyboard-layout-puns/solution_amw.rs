use std::fs::File;
use std::io::prelude::*;
use std::str;
use std::thread;
use std::io::BufReader;
use std::collections::HashSet;
use std::sync::mpsc::channel;
use std::sync::Arc;
use std::ascii::AsciiExt;

// Averages about 57ms on my machine
//
// Spawns 7 threads that each process their own
// chunk of the list of strings. Concurrently
// builds up the final string of all results
// as each thread finishes, then writes results
// to a file.
//

static QD_MAP: [char; 26] = ['a', 'x', 'j', 'e', 'x', 'u', 'i', 'd', 'c', 'h', 't', 'n', 'm', 'b',
                             'r', 'l', 'x', 'p', 'o', 'y', 'g', 'k', 'x', 'q', 'f', 'x'];

static ASCII_LOWCASE_A_OFFSET: u8 = 97;

macro_rules! idx {
    ($c: expr) => {
        (($c.to_ascii_lowercase() as u8) - ASCII_LOWCASE_A_OFFSET) as usize
    }
}

fn main() {
    let file = File::open("/usr/share/dict/words").unwrap();
    let lines: Vec<String> = BufReader::new(file).lines().map(|line| line.unwrap().to_ascii_lowercase()).collect();
    let words: Vec<String> = lines.iter().filter(|word| {
            !word.chars().any(|c| {
                c == 'q' || c == 'w' || c == 'e' || c == 'z'
            })
    })
        .cloned()
        .collect();
    let iter_size = 7;
    let chunk_size = words.len() / iter_size;
    let leftover_words = words.len() - iter_size * chunk_size;

    let index: HashSet<String> = words.iter().filter(|word|
        !word.chars().any(|b| b == 's' || b == 'v' || b == 'w' || b == 'z')
    ).cloned().collect();

    let shared_index = Arc::new(index);
    let shared_words = Arc::new(words);

    let (tx, rx) = channel();

    for i in 0..iter_size {
        let mut results = String::new();
        let cloned_words = shared_words.clone();
        let word_index = shared_index.clone();
        let tx = tx.clone();
        thread::spawn(move || {
            let mut thread_chunk_size = chunk_size;
            if i == iter_size - 1 {
                thread_chunk_size = chunk_size + leftover_words;
            }
            for word in cloned_words.iter().skip(i * chunk_size).take(thread_chunk_size) {
                let converted = word.chars().map(|c| QD_MAP[idx!(c)]).collect::<String>();
                if word_index.contains(&converted) {
                    results.push_str(format!("q:{}|d:{}\n", word, converted).as_str());
                }
            }
            tx.send(results).unwrap();
        });
    }

    let mut results = String::new();
    let mut num_chunks_processed = 0;
    while num_chunks_processed < iter_size {
        let producer_results = rx.recv().unwrap();
        num_chunks_processed += 1;
        results.push_str(producer_results.as_str())
    }
    let mut out_file = File::create("words.txt").unwrap();
    let bytes = results.as_bytes();
    out_file.write_all(bytes).unwrap();
}
