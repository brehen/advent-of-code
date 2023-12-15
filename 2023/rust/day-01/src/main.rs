use std::collections::HashMap;

fn main() {
    let input = include_str!("../input2.txt");
    let lines: Vec<&str> = input.lines().collect();

    let number_map = create_number_map();
    let mut sum = 0;

    for line in lines {
        let numbers = extract_numbers(line, &number_map);

        if let (Some(&first), Some(&last)) = (numbers.first(), numbers.last()) {
            sum += first * 10 + last;
        }
    }

    println!("Sum: {}", sum);
}

fn create_number_map() -> HashMap<&'static str, u32> {
    [
        ("zero", 0),
        ("one", 1),
        ("two", 2),
        ("three", 3),
        ("four", 4),
        ("five", 5),
        ("six", 6),
        ("seven", 7),
        ("eight", 8),
        ("nine", 9),
    ]
    .iter()
    .cloned()
    .collect()
}

fn extract_numbers(line: &str, number_map: &HashMap<&str, u32>) -> Vec<u32> {
    let mut numbers = Vec::new();
    let mut current_word = String::new();

    for ch in line.chars() {
        if ch.is_ascii_digit() {
            if !current_word.is_empty() {
                if let Some(&number) = number_map.get(current_word.as_str()) {
                    numbers.push(number);
                }
                current_word.clear();
            }
            numbers.push(ch.to_digit(10).unwrap());
        } else if ch.is_alphabetic() {
            current_word.push(ch);
        } else {
            if !current_word.is_empty() {
                if let Some(&number) = number_map.get(current_word.as_str()) {
                    numbers.push(number);
                }
                current_word.clear();
            }
        }
    }

    if !current_word.is_empty() {
        if let Some(&number) = number_map.get(current_word.as_str()) {
            numbers.push(number);
        }
    }

    numbers
}
