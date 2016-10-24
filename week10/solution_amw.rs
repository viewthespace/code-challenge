use std::fs::File;
use std::io::prelude::*;
use std::path::Path;
use std::str;
use std::thread;
use std::io::BufReader;
use std::collections::HashSet;
use std::collections::HashMap;
use std::sync::mpsc::channel;

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

fn get_words(mut into_string: &mut String) -> &String {
    let path = Path::new("/usr/share/dict/words");
    let mut file = File::open(&path).unwrap();
    file.read_to_string(into_string);
    into_string
}

fn main() {
    let file = File::open("/usr/share/dict/words").unwrap();
    let size = file.metadata().unwrap().len() as usize;
    let mut words: Vec<String> = BufReader::new(file).lines().map(|line| line.unwrap()).collect();

    let index: HashSet<String> = words.iter().cloned().collect();
    let char_map = qd_map();

    let mut handles = Vec::with_capacity(4);

    // for word in words {
    //     if word.chars().any(|c|
    //                         c == 'q' || c == 'Q' || c == 'w' || c == 'W' ||
    //                         c == 'e' || c == 'E' || c == 'z' || c == 'Z'
    //     ) {
    //         continue
    //     }
    //     let converted = word.chars().map(|c| char_map[&c]).collect::<String>();
    //     if let Some(_) =  index.get(&converted) {
    //         println!("q:{}|d:{}", word, converted);
    //     }
    // }

    let (tx, rx) = channel();

    for (i, chunk) in words.chunks(60000).enumerate() {
        let chunk_words = chunk.to_owned();
        let char_map = qd_map().to_owned();
        let word_index = index.to_owned();
        println!("Pushing thread");
        let tx = tx.clone();
        handles.push(thread::spawn(move || {
            for word in chunk_words {
                if word.chars().any(|c|
                                    c == 'q' || c == 'Q' || c == 'w' || c == 'W' ||
                                    c == 'e' || c == 'E' || c == 'z' || c == 'Z'
                ) {
                    continue
                }
                let converted = word.chars().map(|c| char_map[&c]).collect::<String>();
                if let Some(_) =  word_index.get(&converted) {
                    println!("q:{}|d:{}", word, converted);
                }
            }
            if i == 3 {
                tx.send(()).unwrap();
            }
        }));
    }

    rx.recv().unwrap();

//    for handle in handles {
//        handle.join().unwrap();
//    }
}
