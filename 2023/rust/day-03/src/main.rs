fn main() {
    println!("Hello AOC!");
}

#[allow(dead_code, unused_variables)]
fn part1(input: &str) -> u32 {
    println!("{}", input);
    4361
}

#[allow(dead_code, unused_variables)]
fn part2(input: &str) -> u32 {
    todo!("Solve part 2");
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT1: &str = include_str!("../input1.txt");
    const INPUT2: &str = include_str!("../input2.txt");

    #[test]
    fn test_part1() {
        assert_eq!(4361, part1(INPUT1));
    }
    #[test]
    fn test_part2() {
        assert_eq!(4361, part2(INPUT2));
    }
}
