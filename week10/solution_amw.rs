use std::fs::File;
use std::io::prelude::*;
use std::str;
use std::thread;
use std::io::BufReader;
use std::collections::HashSet;
use std::collections::HashMap;
use std::sync::mpsc::channel;
use std::sync::Arc;

macro_rules! hash {
    ( $( $k:expr => $v:expr ),* ) => {
{
    let mut tmp_hash = HashMap::new();
    $(
        tmp_hash.insert($k, $v);
    )*
        tmp_hash
}
    };
}

enum WorkMsg {
    ChunkResults(Vec<String>)
}

fn qd_map() -> HashMap<char, char> {
    hash!(
        'a' => 'a', 'A' => 'A', 'b' => 'x', 'B' => 'X',
        'c' => 'j', 'C' => 'J', 'd' => 'e', 'D' => 'E',
        'f' => 'u', 'F' => 'U', 'g' => 'i', 'G' => 'I',
        'h' => 'd', 'H' => 'D', 'i' => 'c', 'I' => 'C',
        'j' => 'h', 'J' => 'H', 'k' => 't', 'K' => 'T',
        'l' => 'n', 'L' => 'N', 'm' => 'm', 'M' => 'M',
        'n' => 'b', 'N' => 'B', 'o' => 'r', 'O' => 'R',
        'p' => 'l', 'P' => 'L', 'r' => 'p', 'R' => 'P',
        's' => 'o', 'S' => 'O', 't' => 'y', 'T' => 'Y',
        'u' => 'g', 'U' => 'G', 'v' => 'k', 'V' => 'K',
        'x' => 'q', 'X' => 'Q', 'y' => 'f', 'Y' => 'F'
     )
}

macro_rules! idx {
    ($t:expr) => {
        $t - 97
    }
}

// static qd_map: [u8; 2] = [
//     idx!(b'a'), // a
//     idx!(b'x') // b, etc.
// ];

fn main() {
    let file = File::open("/usr/share/dict/words").unwrap();
    let words: Vec<String> = BufReader::new(file).lines().map(|line| line.unwrap()).collect();

    let iter_size = 8;
    let chunk_size = words.len() / iter_size;

    let index: HashSet<String> = words.iter().cloned().collect();

    let shared_index = Arc::new(index);
    let shared_words = Arc::new(words);

    let (tx_wq, rx_wq) = channel();

    for i in 0..iter_size {
        let cloned_words = shared_words.clone();

        // Try and Arc this
        let char_map = qd_map().to_owned();
        let word_index = shared_index.clone();
        let tx_wq = tx_wq.clone();
        thread::spawn(move || {
            let mut results = vec!();
            for word in cloned_words.iter().skip(i * chunk_size).take(chunk_size) {
                if word.chars().any(|c|
                                    c == 'q' || c == 'Q' || c == 'w' || c == 'W' ||
                                    c == 'e' || c == 'E' || c == 'z' || c == 'Z'
                ) {
                    continue
                }
                let converted = word.chars().map(|c| char_map[&c]).collect::<String>();
                if let Some(_) =  word_index.get(&converted) {
                    results.push(format!("q:{}|d:{}", word, converted));
                }
            }
            tx_wq.send(WorkMsg::ChunkResults(results)).unwrap();
        });
    }
    let file_thread = thread::spawn(move || {
        let mut results = vec!();
        let mut num_chunks_processed = 0;
        while num_chunks_processed < iter_size {
            match rx_wq.recv() {
                Ok(msg) => {
                    match msg {
                        WorkMsg::ChunkResults(producer_results) => {
                            println!("hello: {}", num_chunks_processed);
                            num_chunks_processed += 1;
                            let mut mut_results = producer_results;
                            results.append(&mut mut_results);
                        }
                    }
                },
                _ => {}
            }
        }
        let mut out_file = File::create("words.txt").unwrap();
        let str = results.join("\n");
        let bytes = str.as_bytes();
        out_file.write_all(bytes).unwrap();
    });

    file_thread.join().unwrap();
}
