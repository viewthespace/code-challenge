use std::fs::File;
use std::io::prelude::*;
use std::ascii::AsciiExt;
use std::collections::HashSet;
use std::str;

static QD_MAP: [u8; 26] = [b'a', b'x', b'j', b'e', b'x', b'u', b'i', b'd', b'c', b'h', b't', b'n', b'm', b'b',
                             b'r', b'l', b'x', b'p', b'o', b'y', b'g', b'k', b'x', b'q', b'f', b'x'];

static ASCII_LOWCASE_A_OFFSET: u8 = 97;

macro_rules! idx {
    ($c: expr) => {
        ($c.to_ascii_lowercase() - ASCII_LOWCASE_A_OFFSET) as usize
    }
}

fn main() {
    let mut file = File::open("/usr/share/dict/words").unwrap();

    let file_size = file.metadata().unwrap().len();
    let mut bytes: Vec<u8> = Vec::with_capacity(file_size as usize);
    file.read_to_end(&mut bytes).unwrap();

    let words = bytes.split(|b| *b == b'\n').collect::<Vec<&[u8]>>();
    let convertible_words = words.iter().filter(|word|
        !word.iter().any(|b| *b == b'q' || *b == b'w' || *b == b'e' || *b == b'z')
    );

    let index: HashSet<&[u8]> = words.iter().cloned().collect();

    for word in convertible_words {
        let converted = word.iter().map(|c| QD_MAP[idx!(*c)]).collect::<Vec<u8>>();
        if index.contains(&*converted) {
            println!("q:{}|d:{}", str::from_utf8(word).unwrap(), str::from_utf8(&converted).unwrap());
        }
    }
}
