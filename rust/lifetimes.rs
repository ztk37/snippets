#[derive(Debug)]
pub struct PieceOfData<'a> {
    pub args: Vec<&'a str>,
}

impl<'a> Default for PieceOfData<'a> {
    fn default() -> Self {
        Self {
            args: Vec::new(),
        }
    }
}

impl <'a> PieceOfData<'a> {
    pub fn from_arg(arg: &'a str) -> Self {
        Self {
            args: vec![arg],
        }
    }
    
    pub fn from_args(args: Vec<&'a str>) -> Self {
        Self {
            args
        }
    }
}

impl<'a> From<&'a str> for PieceOfData<'a> {
    fn from(value: &'a str) -> Self {
        PieceOfData::from_arg(value)
    }
}

// impl<'a> From<String> for PieceOfData<'a> {
//     fn from(value: String) -> Self {
//         PieceOfData::from_arg(value)
//     }
// }

// impl<'a> From<&[&str]> for PieceOfData<'a> {
//     fn from(value: &'a [&'a str]) -> Self {
//         PieceOfData {
//             args: value.to_owned(),
//         }
//     }
// }

// impl<'a> From<Vec<String>> for PieceOfData<'a> {
//     fn from(value: Vec<String>) -> Self {
//         PieceOfData::from_args(value.iter().map(|s| s.as_str()).collect::<Vec<_>>())
//     }
// }

fn main() {
    let pod0 = PieceOfData::default();
    
    println!("{:?}", pod0);
    
    let pod1 = PieceOfData::from_arg("argument");
    
    println!("{:?}", pod1);
    
    let pod2 = PieceOfData::from_args(vec!["arg1", "arg2", "arg3"]);
    
    println!("{:?}", pod2);
}
