#[macro_export]
macro_rules! info {
    ($($args:tt)*) => {
        println!("{}: {}", ansi_term::Color::Blue.paint("info"), $($args)*);
    }
}

#[macro_export]
macro_rules! warn {
    ($($args:tt)*) => {
        println!("{}: {}", ansi_term::Color::Yellow.paint("warning"), $($args)*);
    }
}

#[macro_export]
macro_rules! err {
    ($($args:tt)*) => {
        println!("{}: {}", ansi_term::Color::Red.paint("error"), $($args)*);
    }
}


fn main() {
    info!("some message");
    warn!("some message");
    err!("some message");
}
