use std::ops::Add;
use std::marker::PhantomData;

#[derive(Debug)]
struct EUR;

#[derive(Debug)]
struct USD;

#[derive(Debug)]
struct Money<Currency>{
    currency: PhantomData<Currency>,
    value: f64,
}

impl<T> Money<T> {
    fn new(value: f64) -> Money<T> {
        Money{value, currency: PhantomData }
    }
}

impl<Currency> Add for Money<Currency> {
    type Output = Money<Currency>;
    
    fn add(self, other: Money<Currency>) -> Self::Output {
        Money { value: self.value + other.value, currency: PhantomData }
    }
}

fn main() {
    let m1: Money<EUR> = Money::new(10.0);
    let m2: Money<EUR> = Money::new(5.0);
    let m3: Money<USD> = Money::new(5.0);
    
    println!("{:?}", m1 + m2);
    println!("{:?}", m1 + m3);
}
