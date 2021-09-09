pub enum Coin {
    Head,
    Tail
}

pub enum Dice {
    One,
    Two,
    Three,
    Four,
    Five,
    Six
}

pub trait LongName {
    fn long_name(&self) -> String;
}

impl LongName for Coin {
    fn long_name(&self) -> String {
        match &self {
            Coin::Head => "Head".to_string(),
            Coin::Tail => "Tail".to_string()
        }
    }
}

impl LongName for Dice {
    fn long_name(&self) -> String {
        match &self {
            Dice::One => "One".to_string(),
            Dice::Two => "Two".to_string(),
            Dice::Three => "Three".to_string(),
            Dice::Four => "Four".to_string(),
            Dice::Five => "Five".to_string(),
            Dice::Six => "Six".to_string()
        }
    }
}

pub trait ShortName {
    fn short_name(&self) -> String;
}

impl ShortName for Coin {
    fn short_name(&self) -> String {
        match &self {
            Coin::Head => "H".to_string(),
            Coin::Tail => "T".to_string()
        }
    }
}

impl ShortName for Dice {
    fn short_name(&self) -> String {
        match &self {
            Dice::One => "1".to_string(),
            Dice::Two => "2".to_string(),
            Dice::Three => "3".to_string(),
            Dice::Four => "4".to_string(),
            Dice::Five => "5".to_string(),
            Dice::Six => "6".to_string()
        }
    }
}

fn main() {
    println!("{}", ShortName::short_name(&Coin::Head));
    println!("{}", ShortName::short_name(&Coin::Tail));

    println!("{}", ShortName::short_name(&Dice::One));
    println!("{}", ShortName::short_name(&Dice::Two));
    println!("{}", ShortName::short_name(&Dice::Three));
    println!("{}", ShortName::short_name(&Dice::Four));
    println!("{}", ShortName::short_name(&Dice::Five));
    println!("{}", ShortName::short_name(&Dice::Six));
    
    println!("{}", LongName::long_name(&Coin::Head));
    println!("{}", LongName::long_name(&Coin::Tail));

    println!("{}", LongName::long_name(&Dice::One));
    println!("{}", LongName::long_name(&Dice::Two));
    println!("{}", LongName::long_name(&Dice::Three));
    println!("{}", LongName::long_name(&Dice::Four));
    println!("{}", LongName::long_name(&Dice::Five));
    println!("{}", LongName::long_name(&Dice::Six));
}
