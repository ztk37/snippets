#[derive(Debug)]
pub enum Expr {
    Lit(bool),
    Not(Box<Expr>),
    And(Box<Expr>, Box<Expr>),
    Or(Box<Expr>, Box<Expr>),
    All(Box<Vec<Expr>>),
    Any(Box<Vec<Expr>>),
}

pub fn lit(value: bool) -> Expr {
    Expr::Lit(value)
}

pub fn not(expr: Expr) -> Expr {
    Expr::Not(Box::new(expr))
}

pub fn and(a: Expr, b: Expr) -> Expr {
    Expr::And(Box::new(a), Box::new(b))
}

pub fn or(a: Expr, b: Expr) -> Expr {
    Expr::Or(Box::new(a), Box::new(b))
}

pub fn all(xs: Vec<Expr>) -> Expr {
    Expr::All(Box::new(xs))
}

pub fn any(xs: Vec<Expr>) -> Expr {
    Expr::Any(Box::new(xs))
}

pub fn eval(expr: &Expr) -> bool {
    match expr {
        Expr::Lit(value) => value.to_owned(),
        Expr::Not(value) => !eval(value),
        Expr::And(a, b) => eval(a) && eval(b),
        Expr::Or(a, b) => eval(a) || eval(b),
        Expr::All(es) => es.iter().map(eval).all(|x| x),
        Expr::Any(es) => es.iter().map(eval).any(|x| x),
    }
}



fn main() {
    println!("{:?}", eval(&let(true)));
    println!("{:?}", eval(&not(lit(true))));
    println!("{:?}", eval(&and(lit(true), not(lit(false)))));
}
