use std::env;
use std::cmp::Ordering;

fn cmp(v1: &str, v2: &str) -> Option<isize> {
    match v1.partial_cmp(v2) {
        Some(Ordering::Less) => Some(-1),
        Some(Ordering::Greater) => Some(1),
        _ => None,
    }
}

fn n(v: &str) -> Vec<&str> {
    let mut vers_str = v.split(".").collect::<Vec<&str>>();
    let mut padding = vec!["0", "0", "0"];
    vers_str.append(&mut padding);
    vers_str.iter().take(3).cloned().collect()
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let v1n = n(&args[1]);
    let v2n = n(&args[2]);

    let compared = v1n.iter()
        .zip(v2n)
        .filter_map(|p| cmp(p.0, p.1))
        .collect::<Vec<isize>>();

    println!("{}",
             match compared.len() {
                 0 => 0,
                 _ => compared[0],
             });
}
