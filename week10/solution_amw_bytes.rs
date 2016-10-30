use std::fs::File;
use std::io::prelude::*;
use std::ascii::AsciiExt;
use std::collections::HashSet;
use std::time::Instant;
use std::str;

// Averages 49ms
// Operate on references to one vector of bytes,
// rather than create a bunch of heap-allocated Strings.
// Also, convert from Dvorak -> Qwerty since the biggest
// bottleneck is creating the search index, and you can
// eliminate words with the letters 'q', 'w', 'e', and 'z'
// from the Qwerty index.

static DQ_MAP: [u8; 26] = [b'a', b'n', b'i', b'h', b'd', b'y', b'u', b'j', b'g', b'c', b'v', b'p', b'm', b'l', b's', b'r', b's', b'o', 0, b'k', b'f', 0, 0, b'b', b't', 0];

static ASCII_LOWCASE_A_OFFSET: u8 = 97;

macro_rules! idx {
    ($c: expr) => {
        ($c.to_ascii_lowercase() - ASCII_LOWCASE_A_OFFSET) as usize
    }
}

fn add_debug_message(all_messages: &mut Vec<String>, debug_message: &'static str, instant: &Instant) {
    all_messages.push(format!("{}: {:?}ms", debug_message, instant.elapsed().subsec_nanos() as f32 / 1000000.0))
}

fn main() {
    let mut now = Instant::now();
    let total_now = Instant::now();
    let mut messages: Vec<String> = Vec::with_capacity(20);
    let mut file = File::open("/usr/share/dict/words").unwrap();
    let file_size = file.metadata().unwrap().len();
    let mut bytes: Vec<u8> = Vec::with_capacity(file_size as usize);
    file.read_to_end(&mut bytes).unwrap();
    add_debug_message(&mut messages, "Open and read file bytes", &now);

    now = Instant::now();
    let words = bytes.split(|&b| b == b'\n').collect::<Vec<&[u8]>>();
    add_debug_message(&mut messages, "Split bytes into words", &now);

    now = Instant::now();
    let convertible_words = words.iter().filter(|word|
        !word.iter().any(|&b| b == b's' || b == b'v' || b == b'w' || b == b'z' || b == b'-')
    );
    add_debug_message(&mut messages, "Filter convertible words", &now);

    now = Instant::now();
    let target_words: HashSet<&[u8]> = words.iter().filter(|word|
        !word.iter().any(|&b| b == b'q' || b == b'w' || b == b'e' || b == b'z')
    ).cloned().collect();
    add_debug_message(&mut messages, "Create Dvorak search index", &now);

    now = Instant::now();
    for word in convertible_words {
        let converted = word.iter().map(|c| DQ_MAP[idx!(*c)]).collect::<Vec<u8>>();
        if target_words.contains(&*converted) {
            println!("d:{}|q:{}", str::from_utf8(word).unwrap(), str::from_utf8(&converted).unwrap());
        }
    }
    add_debug_message(&mut messages, "Convert all words", &now);
    add_debug_message(&mut messages, "Total time", &total_now);

    for message in messages {
        println!("{}", message);
    }
}
