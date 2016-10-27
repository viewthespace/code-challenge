use std::fs::File;
use std::io::prelude::*;
use std::str;
use std::thread;
use std::io::BufReader;
use std::collections::HashSet;
use std::sync::mpsc::channel;
use std::sync::Arc;
use std::ascii::AsciiExt;

enum WorkMsg {
    ChunkResults(Vec<String>)
}

static QD_MAP: [char; 26] = [
    'a', 'x', 'j', 'e',
    'x', 'u', 'i', 'd',
    'c', 'h', 't', 'n',
    'm', 'b', 'r', 'l',
    'x', 'p', 'o', 'y',
    'g', 'k', 'x', 'q',
    'f', 'x'
];

fn main() {
    let file = File::open("/usr/share/dict/words").unwrap();
    let words: Vec<String> = BufReader::new(file).lines().map(|line| line.unwrap()).filter(|word|
                                                                                           !word.chars().any(|c|
                                                                                            c == 'q' || c == 'Q' || c == 'w' || c == 'W' ||
                                                                                            c == 'e' || c == 'E' || c == 'z' || c == 'Z')
    ).collect();
    let iter_size = 5;
    let chunk_size = words.len() / iter_size;

    let index: HashSet<String> = words.iter().cloned().collect();

    let shared_index = Arc::new(index);
    let shared_words = Arc::new(words);

    let (tx_wq, rx_wq) = channel();

    for i in 0..iter_size {
        let cloned_words = shared_words.clone();

        // Try and Arc this
        let word_index = shared_index.clone();
        let tx_wq = tx_wq.clone();
        thread::spawn(move || {
            let mut results = vec!();
            for word in cloned_words.iter().skip(i * chunk_size).take(chunk_size) {
                let converted = word.chars().map(|c|
                                                 QD_MAP[((c.to_ascii_lowercase() as u8) - 97) as usize]
                ).collect::<String>();
                if let Some(_) =  word_index.get(&converted) {
                    results.push(format!("q:{}|d:{}", word, converted));
                }
            }
            tx_wq.send(WorkMsg::ChunkResults(results)).unwrap();
        });
    }

    let mut results = String::new();
    let mut num_chunks_processed = 0;
    while num_chunks_processed < iter_size {
        match rx_wq.recv().unwrap() {
            WorkMsg::ChunkResults(producer_results) => {
                num_chunks_processed += 1;
                results.push_str(producer_results.join("\n").as_str())
            }
        }
    }
    results.push_str("\n");
    let mut out_file = File::create("words.txt").unwrap();
    let bytes = results.as_bytes();
    out_file.write_all(bytes).unwrap();
}
