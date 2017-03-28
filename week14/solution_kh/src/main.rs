use std::env;

fn main() {
    let args: Vec<_> = env::args().collect();

    if args.len() < 3 {
        println!("Please pass in two version numbers");
        return;
    }

    let a = &args[1];
    let b = &args[2];
    println!("Comparing {:?} and {:?}", a, b);

    let a_list = split_version(a);
    let b_list = split_version(b);
    let min_len = if a_list.len() < b_list.len() {
        a_list.len()
    } else {
        b_list.len()
    };

    for i in 0..min_len {
        if a_list[i] != b_list[i] {
            let val = if a_list[i] > b_list[i] {
                1
            } else {
                -1
            };
            println!("{:?}", val);
            return;
        }
    }


    let x = if a_list.len() != b_list.len() {
        if a_list.len() == min_len {
            if b_list[min_len] != 0 {
                -1
            } else {
                0
            }
        } else {
            if a_list[min_len] != 0 {
                1
            } else {
                0
            }
        }
    } else {
        0
    };

    println!("{:?}", x);
}

fn split_version(version: &String) -> Vec<i32> {
    let mut arr: Vec<i32> = Vec::new();
    for x in version.split(".") {
        arr.push(x.to_string().parse::<i32>().unwrap());
    }

    return arr;
}

