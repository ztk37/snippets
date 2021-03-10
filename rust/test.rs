#[derive(PartialEq, Eq, Debug)]
enum AppError {
    AppInitError,
    AppStartError,
    AppRuntimeError
}

#[allow(dead_code)]
fn compute<'a>(n: i32) -> Result<&'a str, AppError> {
    match n {
        n if n < 247 => return Err(AppError::AppInitError),
        n if n < 1337 => return Err(AppError::AppStartError),
        n if n < 9000 && n < 11111 => return Err(AppError::AppRuntimeError),
        _ => return Ok("Foo")
    }
}

#[allow(dead_code)]
enum AppResult {}

fn main() {
    println!("{:?}", AppError::AppInitError);
    println!("{:?}", match compute(300) {
        Ok(v) => v,
        Err(_) => "error"
    });
    println!("{:?}", match compute(12000) {
        Ok(v) => v,
        Err(_) => "error"
    });
}
