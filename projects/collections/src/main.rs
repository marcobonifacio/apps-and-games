use std::collections::HashMap;
use std::ops::Add;

fn get_median_even(numbers: Vec<i32>) -> f64 {
    numbers[numbers.len() / 2].into()
}

fn get_median_odd(numbers: Vec<i32>) -> f64 {
    <i32 as Into<f64>>::into(
        numbers[numbers.len() / 2] + numbers[numbers.len() / 2 - 1]
    ) / 2.0
}

fn get_median(numbers: Vec<i32>) -> f64 {
    match numbers.len() % 2 == 0 {
        true => get_median_even(numbers),
        false => get_median_odd(numbers),
    }
}

fn vectorize_and_sort(numbers: &[i32]) -> Vec<i32> {
    let mut v = Vec::from(numbers); v.sort();
    v
}

fn counter(numbers: &[i32]) -> HashMap<i32, i32> {
    let mut result: HashMap<i32, i32> = HashMap::new();
    numbers.into_iter().for_each(|n| {
        let count = result.entry(*n).or_insert(0);
        *count +=1;
    });
    result
}

fn invert_hashmap(hash: HashMap<i32, i32>) -> HashMap<i32, i32> {
    HashMap::<i32, i32>::from_iter(
        hash.iter().map(|(k, v)| (*v, *k))
    )
}

fn median_and_mode(numbers: &[i32]) -> (f64, i32) {
    let v = vectorize_and_sort(&numbers);
    let med = get_median(v);
    let h = counter(&numbers);
    let h_inv  = invert_hashmap(h);
    let max = h_inv.keys().max();
    let mode = h_inv[max.expect("Fail!")];
    
    (med, mode)
}

fn vectorize_string(s: &str) -> Vec<&str> {
    let v: Vec<&str> = s.split(' ').collect();
    v
}

fn vectorize_word(w: &str) -> Vec<char> {
    let v: Vec<char> = w.chars().collect();
    v
}

fn consonant_word(w: Vec<char>) -> String {
    let mut result = String::new();
    (&w[1..]).into_iter().for_each(|c| {
        result.push(*c);
    });
    result.push(w[0]);
    result = result.clone().add("-ay ");
    result
}

fn vowel_word(w: Vec<char>) -> String {
    let mut result = String::new();
    let word: String = w.into_iter().collect();
    result = result.add(&word).add("-hay ");
    result
}

fn vec_to_word(w: Vec<char>) -> String {
    match w[0] == 'a' || w[0] == 'e' || w[0] == 'i' || w[0] == 'o' || w[0] == 'u' {
        true => vowel_word(w),
        false => consonant_word(w),
    }
}

fn pig_latin(sentence: &str) -> String {
    let v = vectorize_string(sentence);
    let mut result = String::new();
    v.into_iter().for_each(|word| {
        result = result.clone().add(&vec_to_word(vectorize_word(word)));
    });
    result
}

fn main() {
    let numbers = [3, 4, 5, 6, 6, 4, 7, 8, 4];
    let (med, mode) = median_and_mode(&numbers);
    println!("La mediana è {} e la moda è {}.", med, mode);
    let sentence = "the lazy fox jumps over the brown dog";
    let pig = pig_latin(&sentence);
    println!("{}", pig);
}
