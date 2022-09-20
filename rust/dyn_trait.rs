trait SomeTrait {
    fn some_value(&self) -> bool;
}

#[derive(Debug)]
struct A {
    pub v: bool,
}

impl SomeTrait for A {
    fn some_value(&self) -> bool {
        self.v
    }
}

#[derive(Debug)]
struct B {
    pub v: bool,
}

impl SomeTrait for B {
    fn some_value(&self) -> bool {
        self.v
    }
}

#[derive(Debug)]
struct C {
    pub v: bool,
}

impl SomeTrait for C {
    fn some_value(&self) -> bool {
        self.v
    }
}

#[derive(Debug)]
pub enum Kind {
    A,
    B,
    C
}

fn from_kind(kind: Kind) -> Box<dyn SomeTrait> {
    match kind {
        Kind::A => Box::new(A { v: true }),
        Kind::B => Box::new(B { v: true }),
        Kind::C => Box::new(C { v: true }),
    }
}

fn main() {
    let something = from_kind(Kind::A);
    
    println!("{:?}", something.some_value());
}
