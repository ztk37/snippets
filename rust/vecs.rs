fn main() {
   let words = vec!["foo", "bar", "fib"];

    println!("{:?}", words);
    
    let words_upper: Vec<String> = words.into_iter()
        .map(|word| word.to_uppercase())
        .collect();
    
    println!("{:?}", words_upper);
}
