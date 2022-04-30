mod app {
    pub mod constants {
        pub const SOMETHING: &'static str= "SOMETHING";
    }
    
    pub mod types {
        #[derive(Debug)]
        pub enum ABC {
            A,
            B,
            C
        }
    }
    
    pub enum AppError {
        InitError
    }
    
    pub type AppResult = Result<(), AppError>;
}

use app::{AppResult, AppError};

pub fn run() -> AppResult {
    if true {
        return Err(AppError::InitError);
    }
    
    Ok(())
}

fn main() {
    println!("{:?}", app::types::ABC::A);
    println!("{:?}", app::types::ABC::B);
    println!("{:?}", app::types::ABC::C); 
    
    println!("{}", app::constants::SOMETHING);
    
    println!("{}", match run() {
        Err(AppError::InitError) => "Just no",
        Ok(()) => "Ok do it"
    });
}
