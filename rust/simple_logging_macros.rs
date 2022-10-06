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

#[macro_export]
macro_rules! log {
    (red, $arg:expr, $($rest:tt)*) => {
        println!("{} {}", ansi_term::Color::Red.paint($arg), $($rest)*);
    };

    (green, $arg:expr, $($rest:tt)*) => {
        println!("{} {}", ansi_term::Color::Green.paint($arg), $($rest)*);
    };

    (blue, $arg:expr, $($rest:tt)*) => {
        println!("{} {}", ansi_term::Color::Blue.paint($arg), $($rest)*);
    };
}

fn main() {
    info!("some message");
    warn!("some message");
    err!("some message");
    
    
    log!(red, "* something in red", "some message");
    log!(green, "* something in green", "some message");
    log!(blue, "* something in blue", "some message");
}
