#[derive(Debug)]
pub struct PieceOfData<'a> {
    pub args: &'a [&'a str],
}

impl<'a> From<&'a [&'a str]> for PieceOfData<'a> {
    fn from(args: &'a [&'a str]) -> Self {
        PieceOfData {
            args,
        }
    }
}

fn main() {
    let mut pod = PieceOfData {
        args: &["a", "b", "c"],
    };
    
    pod.args = &["a", "b", "c", "d"];
    
    println!("{:?}", pod);
}
