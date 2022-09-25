macro_rules! warn {
     ($($arg:tt)*) => ({
        println!("warn: {}", format!($($arg)*));
    })
}

macro_rules! error {
     ($($arg:tt)*) => ({
        println!("error: {}", format!($($arg)*));
    })
}

fn main() {
    warn!("foo");
    error!("foo");
}
