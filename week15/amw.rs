#[derive(Debug, PartialEq)]
enum Direction {
    Ascending,
    Descending,
}

fn direction(l: isize, r: isize) -> Direction {
    match (l, r) {
        (x, y) if x < y => Direction::Ascending,
        (x, y) if x > y => Direction::Descending,
        _ => panic!("This should never happen"),
    }
}

fn multiple_inflection_points(inf_pts: &Vec<usize>, prices: &Vec<isize>) -> Option<isize> {
    let mut max = 0;
    for i in 0..inf_pts.len() - 1 {
        unsafe {
            NUM_ITERATIONS += 1;
        }
        let diff = prices[inf_pts[i + 1]] - prices[inf_pts[i]];
        if diff > 0 && diff > max {
            max = diff
        }
    }
    if max == 0 { None } else { Some(max) }
}

static mut NUM_ITERATIONS: isize = 0;

fn main() {
    let inputs: Vec<Vec<isize>> = vec! [
        vec![220, 214, 60, 110, 55, 126, 42],
        vec![9, 12, 4, 10, 11],
        vec![5,4,3,2,1],
        vec![1, 100, 15, 20, 200, 23, 1, 10, 1000, 900],
        vec![1, 100, 15, 20, 22, 23, 22, 10, 9, 8],
    ];
    for (i, prices) in inputs.iter().enumerate() {
        println!("=======================================");
        println!(" Run {}", i);
        println!("---------------------------------------");
        let mut inf_pts: Vec<usize> = Vec::with_capacity(prices.len());
        inf_pts.push(0);
        let mut dir = direction(prices[0], prices[1]);
        for i in 0..prices.len() - 1 {
            let pi = prices[i];
            let pin = prices[i + 1];
            let new_dir = direction(pi, pin);
            if new_dir != dir {
                inf_pts.push(i);
                dir = new_dir;
            }
            unsafe {
                NUM_ITERATIONS += 1;
            }
        }
        inf_pts.push(prices.len() - 1);

        match multiple_inflection_points(&inf_pts, &prices) {
            Some(gsd) => println!("   Greatest sequential difference = {}", gsd),
            None => println!("   You can't make any money on this one."),
        };

        println!("   N was {}", prices.len());
        unsafe {
            println!("   Found the gsd in {} iterations.", NUM_ITERATIONS);
            NUM_ITERATIONS = 0;
        }
        println!("---------------------------------------");
        println!("");
    }
}
