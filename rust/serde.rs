use serde::{Serialize, Deserialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct Pair {
  a: i64,
  b: i64
}

impl Pair {
    pub fn empty() -> Self {
        Pair { a: 0, b: 0 }
    }
    
    pub fn new(a: i64, b: i64) -> Self {
        Pair { a , b }
    }
}

#[derive(Debug, Serialize, Deserialize)]
pub enum ABC {
    #[serde(rename="a")]
    A,
    #[serde(rename="b")]
    B,
    #[serde(rename="c")]
    C
}

#[derive(Debug, Serialize, Deserialize)]
pub struct Values {
    abc: ABC
}

impl Default for Values {
    fn default() -> Self {
        Values { abc: ABC::A }
    }
}

fn main() {
    println!("{:?}", Pair::empty());
    println!("{}", serde_json::to_string(&Pair::empty()).unwrap());
    
    println!("{:?}", ABC::A);
    println!("{:?}", ABC::B);
    println!("{:?}", ABC::C);
    println!("{}", serde_json::to_string(&ABC::A).unwrap());
    
    let values: Values = Default::default();
    
    println!("{:?}", values);
    println!("{}", serde_json::to_string(&values).unwrap());
}
