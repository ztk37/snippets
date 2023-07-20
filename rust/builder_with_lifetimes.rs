#[derive(Debug)]
pub struct Builder<'a> {
    name: &'a str,
    tags: Vec<&'a str>,
}

impl<'a> Builder<'a> {
    pub fn new(name: &'a str) -> Self {
        Self {
            name,
            tags: Vec::new(),
        }
    }
    
    pub fn add_tag(mut self, tag: &'a str) -> Self {
        self.tags.push(tag.as_ref());
        self
    }
    
    pub fn build(&self) -> (&'a str, Vec<&'a str>) {
        (self.name, self.tags.clone())
    }
}

fn main() {
    let (name, tags) = Builder::new("builder")
        .add_tag("foo")
        .add_tag("bar")
        .build();
    
    println!("{:?}", name);
    println!("{:?}", tags);
}
