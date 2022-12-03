#[derive(Debug, Default)]
struct Vector {
    x: i64,
    y: i64,
    z: i64,
}

impl Vector {
    fn new(x: i64, y: i64, z: i64) -> Self {
        Vector { x, y, z }
    }
}

type Triple<T> = (T, T, T);

impl Into<Triple<i64>> for Vector {
    fn into(self) -> Triple<i64> {
        (self.x, self.y, self.z)
    }   
}

impl Into<Vector> for Triple<i64> {
    fn into(self) -> Vector {
        Vector::new(self.0, self.1, self.2)
    }
}

fn main() {
    let vector = Vector::default();
    let triple: Triple<i64> = (1, 2, 3);
    
    let t: Triple<i64> = vector.into();
    let v: Vector = triple.into();
    
    println!("{:?}", t);
    println!("{:?}", v);
}
