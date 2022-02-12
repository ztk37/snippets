#[derive(Debug, Clone, Copy)]
pub enum ABC {
    A,
    B,
    C
}

impl TryFrom<i32> for ABC {
    type Error = ();

    fn try_from(n: i32) -> Result<Self, Self::Error> {
        match n {
            0 => Ok(ABC::A),
            1 => Ok(ABC::B),
            2 => Ok(ABC::C),
            _ => Err(())
        }
    }
}

fn add(a: i64, b: i64) -> i64 {
    a + b
}

fn main() {
    let abc: Result<ABC, ()> = TryFrom::try_from(3);

    match abc {
        Ok(inner) => println!("{:?}", inner),
        Err(()) => println!("can't convert to ABC")
    }

    println!("{}", add(4, 5));
    println!("{:?}", abc);
}
