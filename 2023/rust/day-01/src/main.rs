fn main() {
    println!("Hello AOC!");
}

fn part1(input: &str) -> &str {
    input
}

fn part2(input: &str) -> &str {
    input
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1() {
        let input = include_str!("../input1.txt");
        assert_eq!("123", part1(input));
    }
    #[test]
    fn test_part2() {
        let input = include_str!("../input1.txt");
        assert_eq!("", part2(input));
    }
}
