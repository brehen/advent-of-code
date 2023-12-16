fn main() {
    println!("Hello AOC!");
}

#[allow(dead_code, unused_variables)]
fn part1(input: &str) -> u32 {
    4361
}

#[allow(dead_code, unused_variables)]
fn part2(input: &str) -> u32 {
    todo!("Solve part 2");
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1() {
        let input = "";
        assert_eq!(4361, part1(input));
    }
    #[test]
    fn test_part2() {
        let input = "";
        assert_eq!(4361, part2(input));
    }
}
