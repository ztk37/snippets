use std::fmt::{Display, Formatter};

pub enum AppError {
    InitError
}

impl Display for AppError {
    fn fmt(&self, f: &mut Formatter<'_>) -> Result<(), std::fmt::Error> {
        write!(f, "{}", match self {
            AppError::InitError => "InitError"
        })
    }
}

pub type AppResult<T> = Result<T, AppError>;

pub fn run(n: i64) -> AppResult<()> {
    if n != 42 {
        return Err(AppError::InitError)
    }

    Ok(())
}

fn main() {
    match run(21) {
        Err(err) => println!("Reason {}", err),
        Ok(()) => println!("The answer"),
    }
}
