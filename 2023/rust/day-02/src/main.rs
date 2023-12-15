use itertools::Itertools;
use regex::Regex;

fn main() {
    println!("Hello AOC!");
}

#[allow(dead_code)]
const R_LIM: u16 = 12;
#[allow(dead_code)]
const G_LIM: u16 = 13;
#[allow(dead_code)]
const B_LIM: u16 = 14;

const GAME_REGEXP: &str = r"Game (\d+): ([\d\s\w,;]+)";
const BLUE_REGEXP: &str = r"(\d+) blue";
const RED_REGEXP: &str = r"(\d+) red";
const GREEN_REGEXP: &str = r"(\d+) green";

#[allow(dead_code)]
fn part1(input: &str) -> u32 {
    let game_re = Regex::new(GAME_REGEXP).unwrap();
    let red_re = Regex::new(RED_REGEXP).unwrap();
    let green_re = Regex::new(GREEN_REGEXP).unwrap();
    let blue_re = Regex::new(BLUE_REGEXP).unwrap();
    let games = input
        .lines()
        .map(|game| match game_re.captures(game) {
            Some(caps) => {
                let id = caps.get(1).map_or("", |m| m.as_str());
                let sets = caps.get(2).map_or("", |m| m.as_str());

                let reds: Vec<u16> = red_re
                    .captures_iter(sets)
                    .filter_map(|caps| caps.get(1))
                    .map(|mat| mat.as_str().parse::<u16>().unwrap())
                    .collect();

                let greens: Vec<u16> = green_re
                    .captures_iter(sets)
                    .filter_map(|caps| caps.get(1))
                    .map(|mat| mat.as_str().parse::<u16>().unwrap())
                    .collect();
                let blues: Vec<u16> = blue_re
                    .captures_iter(sets)
                    .filter_map(|caps| caps.get(1))
                    .map(|mat| mat.as_str().parse::<u16>().unwrap())
                    .collect();

                let reds_above_lim: Vec<u16> =
                    reds.iter().filter(|&&red| red > R_LIM).cloned().collect();
                let blues_above_lim: Vec<u16> = blues
                    .iter()
                    .filter(|&&blue| blue > B_LIM)
                    .cloned()
                    .collect();
                let greens_above_lim: Vec<u16> = greens
                    .iter()
                    .filter(|&&green| green > G_LIM)
                    .cloned()
                    .collect();

                let possible_game = reds_above_lim.is_empty()
                    && blues_above_lim.is_empty()
                    && greens_above_lim.is_empty();

                (id.parse::<u8>().unwrap(), possible_game)
            }
            None => {
                println!("How did I get in here?");
                (0, false)
            }
        })
        .filter(|(_, possible)| *possible)
        .map(|(id, _)| id as u32)
        .sum::<u32>();
    games
}

#[allow(dead_code)]
fn part2(input: &str) -> u32 {
    let game_re = Regex::new(GAME_REGEXP).unwrap();
    let red_re = Regex::new(RED_REGEXP).unwrap();
    let green_re = Regex::new(GREEN_REGEXP).unwrap();
    let blue_re = Regex::new(BLUE_REGEXP).unwrap();
    let games: u32 = input
        .lines()
        .map(|game| match game_re.captures(game) {
            Some(caps) => {
                let sets = caps.get(2).map_or("", |m| m.as_str());

                let reds: Vec<u16> = red_re
                    .captures_iter(sets)
                    .filter_map(|caps| caps.get(1))
                    .map(|mat| mat.as_str().parse::<u16>().unwrap())
                    .sorted()
                    .collect();

                let greens: Vec<u16> = green_re
                    .captures_iter(sets)
                    .filter_map(|caps| caps.get(1))
                    .map(|mat| mat.as_str().parse::<u16>().unwrap())
                    .sorted()
                    .collect();
                let blues: Vec<u16> = blue_re
                    .captures_iter(sets)
                    .filter_map(|caps| caps.get(1))
                    .map(|mat| mat.as_str().parse::<u16>().unwrap())
                    .sorted()
                    .collect();

                let largest_red = reds.last().unwrap();
                let largest_green = greens.last().unwrap();
                let largest_blue = blues.last().unwrap();

                (largest_red * largest_blue * largest_green) as u32
            }
            None => {
                println!("How did I get in here?");
                0
            }
        })
        .sum();
    games
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part1() {
        let input = include_str!("../input1.txt");
        assert_eq!(8, part1(input));
        let input2 = include_str!("../input2.txt");
        assert_eq!(2369, part1(input2));
    }
    #[test]
    fn test_part2() {
        let input = include_str!("../input1.txt");
        assert_eq!(2286, part2(input));
        let input = include_str!("../input2.txt");
        assert_eq!(66363, part2(input));
    }
}
